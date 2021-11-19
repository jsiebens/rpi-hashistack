source "arm-image" "ubuntu_arm64" {
  additional_chroot_mounts = [["bind", "/run/systemd", "/run/systemd"]]
  image_mounts             = ["/boot/firmware", "/"]
  image_type               = "raspberrypi"
  iso_checksum             = "sha256:7e405f473d8a9e3254cd702edaeecd5509a85cde1e9e99e120f6c82156c6958f"
  iso_url                  = "https://cdimage.ubuntu.com/releases/20.04.3/release/ubuntu-20.04.3-preinstalled-server-arm64+raspi.img.xz"
  output_filename          = "images/rpi-hashistack-ubuntu-arm64.img"
  qemu_binary              = "qemu-aarch64-static"
}