#!/bin/bash
pacman -Syu --noconfirm
pacman -S --noconfirm --needed base-devel aarch64-linux-gnu-gcc

builddir="$RUNNER_TEMP/linux-amlogic"
cp -r "$GITHUB_WORKSPACE/linux-amlogic" "$builddir"
chown nobody:root "$builddir"
cd "$builddir" || exit 1

echo "nobody ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

sudo -u nobody /usr/bin/env ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- makepkg --syncdeps --noconfirm --config "$GITHUB_WORKSPACE/makepkg.conf"

mkdir "$RUNNER_TEMP/pkg"
mv ./*.pkg.tar.zst "$RUNNER_TEMP/pkg"
ls -l "$RUNNER_TEMP/pkg"