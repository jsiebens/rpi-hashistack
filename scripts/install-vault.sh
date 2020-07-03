#!/bin/bash
set -e

echo "Fetching Vault... ${VAULT_VERSION}"
mkdir -p /tmp/vault
pushd /tmp/vault

curl -Os https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_arm.zip
curl -Os https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS
curl -Os https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig

# Verify the signature file is untampered.
gpg --homedir /tmp/keyring --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS

# Verify the SHASUM matches the archive.
shasum -a 256 -c vault_${VAULT_VERSION}_SHA256SUMS --ignore-missing

echo "Installing Vault..."
unzip vault_${VAULT_VERSION}_linux_arm.zip >/dev/null
mv vault /usr/local/bin/
setcap cap_ipc_lock=+ep /usr/local/bin/vault

useradd --system --home /etc/vault.d --shell /bin/false vault

mkdir --parents /etc/vault.d

cat - > /etc/vault.d/vault.hcl <<'EOF'
ui = true

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}
EOF

chmod 640 /etc/vault.d/vault.hcl
chown --recursive vault:vault /etc/vault.d

echo "Installing Vault as a Service..."
cat - > /etc/systemd/system/vault.service <<'EOF'
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitInterval=60
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
EOF
chmod 0600 /etc/systemd/system/vault.service

systemctl enable vault.service

popd
rm -rf /tmp/vault

echo "Vault installation finished."