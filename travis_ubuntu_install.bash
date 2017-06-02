#!/usr/bin/env bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get -qq update
sudo apt-get -qq install g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
