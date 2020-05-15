#!/bin/bash
pacman -Syu --noconfirm
pacman -S --noconfirm --needed base-devel aarch64-linux-gnu-gcc

echo "nobody ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

builddir="$RUNNER_TEMP/linux-amlogic"
cp -r "$GITHUB_WORKSPACE/linux-amlogic" "$builddir"
chown nobody:root "$builddir"
cd "$builddir" || exit 1

sudo -u nobody /usr/bin/env ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- makepkg --syncdeps --noconfirm --config "$GITHUB_WORKSPACE/makepkg.conf"

mkdir -p "$GITHUB_WORKSPACE/dist"
cp ./*.pkg.tar.zst "$GITHUB_WORKSPACE/dist"