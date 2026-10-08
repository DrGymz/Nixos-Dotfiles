#!/usr/bin/env bash
set -euo pipefail

# Must match users.users.* in configuration.nix and nixosConfigurations.* in flake.nix
USER_NAME="asus"
HOST="nixos"

DEST="/mnt/home/$USER_NAME/dotfiles"

echo "=== NixOS Installer ==="
echo ""

if ! command -v git &>/dev/null; then
  echo "Error: git not found. The live ISO doesn't ship it."
  echo "Re-run inside: nix-shell -p git"
  exit 1
fi

if [[ ! -d /sys/firmware/efi ]]; then
  echo "Error: booted in legacy BIOS mode, but configuration.nix uses systemd-boot."
  echo "Reboot the installer in UEFI mode."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || echo "$SCRIPT_DIR")"
echo "Installing from: $REPO_DIR"

if [[ "$REPO_DIR" == /mnt/* ]]; then
  echo "Error: run this from a clone outside /mnt."
  exit 1
fi

# --- Disk selection ---
echo ""
lsblk -d -o NAME,SIZE,MODEL
echo ""
read -rp "Enter target disk (e.g. /dev/nvme0n1 or /dev/sda): " DISK

if [[ ! -b "$DISK" ]]; then
  echo "Error: $DISK is not a valid block device."
  exit 1
fi

echo ""
echo "WARNING: This will ERASE ALL DATA on $DISK"
lsblk "$DISK"
echo ""
read -rp "Type 'yes' to continue: " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 1
fi

# --- Partitioning ---
echo ""
echo "[1/7] Partitioning $DISK..."

swapoff -a || true
umount -R /mnt 2>/dev/null || true
wipefs -a "$DISK"

parted --script --align optimal "$DISK" -- \
  mklabel gpt \
  mkpart ESP fat32 1MiB 1GiB \
  set 1 esp on \
  mkpart swap linux-swap 1GiB 9GiB \
  mkpart root ext4 9GiB 100%

# Determine partition names (nvme uses p1/p2/p3, sata uses 1/2/3)
if [[ "$DISK" == *"nvme"* || "$DISK" == *"mmcblk"* ]]; then
  PART1="${DISK}p1"
  PART2="${DISK}p2"
  PART3="${DISK}p3"
else
  PART1="${DISK}1"
  PART2="${DISK}2"
  PART3="${DISK}3"
fi

# Wait for /dev nodes to appear before formatting
partprobe "$DISK" || true
udevadm settle
for p in "$PART1" "$PART2" "$PART3"; do
  [[ -b "$p" ]] || { echo "Error: $p never appeared."; exit 1; }
done

# --- Formatting ---
echo "[2/7] Formatting partitions..."
wipefs -a "$PART1" "$PART2" "$PART3"
mkfs.fat -F 32 -n BOOT "$PART1"
mkswap -L SWAP "$PART2"
mkfs.ext4 -F -L NIXOS "$PART3"

# --- Mounting ---
echo "[3/7] Mounting filesystems..."
mount "$PART3" /mnt
mkdir -p /mnt/boot
mount "$PART1" /mnt/boot
swapon "$PART2"

# --- Generate hardware config ---
echo "[4/7] Generating hardware-configuration.nix..."
nixos-generate-config --root /mnt

# --- Copy dotfiles to user home ---
echo "[5/7] Copying dotfiles to /home/$USER_NAME/dotfiles..."
mkdir -p "$DEST"
cp -a "$REPO_DIR"/. "$DEST"/

cp /mnt/etc/nixos/hardware-configuration.nix "$DEST/hardware-configuration.nix"

# Flakes only see git-tracked files, so stage the new hardware config
if [[ -d "$DEST/.git" ]]; then
  git -C "$DEST" add hardware-configuration.nix
fi

# --- Install ---
echo "[6/7] Running nixos-install (this will take a while)..."
nixos-install --flake "$DEST#$HOST" --no-root-passwd

# --- Passwords ---
echo ""
echo "[7/7] Setting passwords..."
echo "--- Set root password ---"
nixos-enter --root /mnt -- passwd root
echo ""
echo "--- Set $USER_NAME password ---"
nixos-enter --root /mnt -- passwd "$USER_NAME"

nixos-enter --root /mnt -- chown -R "$USER_NAME:users" "/home/$USER_NAME"

echo ""
echo "=== Installation complete! ==="
echo "  1. reboot"
echo "  2. Log in as '$USER_NAME'"
echo "  3. Rebuild with: nrs   (sudo nixos-rebuild switch --flake ~/dotfiles#$HOST)"
