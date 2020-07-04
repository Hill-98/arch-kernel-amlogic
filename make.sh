#!/bin/bash
yes | pacman -Syu --noconfirm
yes | pacman -S --noconfirm --needed base-devel aarch64-linux-gnu-gcc

builddir="$RUNNER_TEMP/linux-amlogic"
cp -r "$GITHUB_WORKSPACE/linux-amlogic" "$builddir"
chown nobody:root "$builddir"
cd "$builddir" || exit 1

echo "nobody ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

sudo -u nobody env \
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- KBUILD_BUILD_HOST=github KBUILD_BUILD_USER=$GITHUB_REPOSITORY_OWNER \
    makepkg --syncdeps --noconfirm --config "$GITHUB_WORKSPACE/makepkg.conf" || exit 1

mkdir "$RUNNER_TEMP/pkg"
mv ./*.pkg.tar.zst "$RUNNER_TEMP/pkg"
ls -l "$RUNNER_TEMP/pkg"
