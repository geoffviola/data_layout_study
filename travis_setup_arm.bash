#!/usr/bin/env bash

if [ $# -lt 1 ]; then
        echo "Usage: $0 emu dir"
        exit 1
fi

CHROOT_DIR=$2
MIRROR=http://archive.raspbian.org/raspbian
VERSION=wheezy
CHROOT_ARCH=armhf

# Debian package dependencies for the host
HOST_DEPENDENCIES="debootstrap qemu-user-static binfmt-support sbuild"

# Debian package dependencies for the chrooted environment
GUEST_DEPENDENCIES="build-essential git m4 sudo python"

# Host dependencies
sudo apt-get install -qq -y ${HOST_DEPENDENCIES}

# Create chrooted environment
sudo mkdir ${CHROOT_DIR}
sudo debootstrap --foreign --no-check-gpg --include=fakeroot,build-essential \
    --arch=${CHROOT_ARCH} ${VERSION} ${CHROOT_DIR} ${MIRROR}
sudo cp /usr/bin/qemu-arm-static ${CHROOT_DIR}/usr/bin/
sudo chroot ${CHROOT_DIR} ./debootstrap/debootstrap --second-stage
sudo sbuild-createchroot --arch=${CHROOT_ARCH} --foreign --setup-only \
    ${VERSION} ${CHROOT_DIR} ${MIRROR}

# Create file with environment variables which will be used inside chrooted
# environment
echo "export ARCH=${ARCH}" > envvars.sh
echo "export TRAVIS_BUILD_DIR=${TRAVIS_BUILD_DIR}" >> envvars.sh
chmod a+x envvars.sh

# Install dependencies inside chroot
sudo chroot ${CHROOT_DIR} apt-get update
sudo chroot ${CHROOT_DIR} apt-get --allow-unauthenticated install \
    -qq -y ${GUEST_DEPENDENCIES}

# Create build dir and copy travis build files to our chroot environment
sudo mkdir -p ${CHROOT_DIR}/${TRAVIS_BUILD_DIR}
sudo rsync -av ${TRAVIS_BUILD_DIR}/ ${CHROOT_DIR}/${TRAVIS_BUILD_DIR}/

# Indicate chroot environment has been set up
#sudo touch ${CHROOT_DIR}/.chroot_is_done

# Call ourselves again which will cause tests to run
#sudo chroot ${CHROOT_DIR} bash -c "cd ${TRAVIS_BUILD_DIR} && ./.travis-ci.sh"

echo ARM SETUP
pwd
ls
sudo chroot ${CHROOT_DIR} bash -c "pwd && ls"
sudo chroot ${CHROOT_DIR} bash -c "uname -a"
cd ${CHROOT_DIR}
pwd
ls
