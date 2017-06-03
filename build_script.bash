#!/usr/bin/env bash

mkdir build
cd build
cmake -DCMAKE_CXX_FLAGS="-std=c++11" ..
make
./data_layout_study
