#!/bin/bash
pacman -Syu --noconfirm
pacman -S --noconfirm --needed base-devel aarch64-linux-gnu-gcc

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

echo "nobody ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

repodir=$(dirname "$0")

cp -r "$repodir/linux-amlogic" "/github/workflow/linux-amlogic"

chown nobody:root /github/workflow/linux-amlogic

cd /github/workflow/linux-amlogic || exit 1

sudo -u nobody makepkg --syncdeps --noconfirm --config "$repodir/makepkg.conf"