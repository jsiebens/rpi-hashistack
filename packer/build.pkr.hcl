build {
  sources = [
    "source.arm-image.ubuntu_arm64",
  ]

  provisioner "shell" {
    scripts = [
      "scripts/install-hashistack.sh"
    ]
  }
}