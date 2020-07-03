#!/bin/bash
set -e

echo "Fetching Consul... ${CONSUL_VERSION}"
mkdir -p /tmp/consul
cd /tmp/consul

curl -Os https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_armhfv6.zip
curl -Os https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS
curl -Os https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig

# Verify the signature file is untampered.
gpg --homedir /tmp/keyring --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS

# Verify the SHASUM matches the archive.
shasum -a 256 -c consul_${CONSUL_VERSION}_SHA256SUMS --ignore-missing

echo "Installing Consul..."
unzip consul_${CONSUL_VERSION}_linux_armhfv6.zip >/dev/null
mv consul /usr/local/bin/

useradd --system --home /etc/consul.d --shell /bin/false consul

mkdir --parents /opt/consul
mkdir --parents /etc/consul.d

cat - > /etc/consul.d/consul.hcl <<'EOF'
advertise_addr = "{{ GetPrivateInterfaces | include \"type\" \"IP\" | attr \"address\" }}"
client_addr = "0.0.0.0"
data_dir = "/opt/consul"
bootstrap_expect = 1
retry_join = [ "127.0.0.1" ]
server = true
ui = true
EOF

chmod 640 /etc/consul.d/consul.hcl
chown --recursive consul:consul /opt/consul
chown --recursive consul:consul /etc/consul.d

echo "Installing Consul as a Service..."
cat - > /etc/systemd/system/consul.service <<'EOF'
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=notify
User=consul
Group=consul
ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/usr/local/bin/consul reload
ExecStop=/usr/local/bin/consul leave
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
chmod 0600 /etc/systemd/system/consul.service

systemctl enable consul.service

cd
rm -rf /tmp/consul

echo "Consul installation finished."