#!/bin/bash
pacman -Syu --noconfirm
pacman -S --noconfirm --needed base-devel aarch64-linux-gnu-gcc

cd "$(dirname $0)/linux-amlogic"

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

useradd cl-build
echo "cl-build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

sudo -u cl-build makepkg --syncdeps --noconfirm --config ../makepkg.conf