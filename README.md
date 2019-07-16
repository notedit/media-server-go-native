# media-server-go-native

[![Build Status](https://travis-ci.org/notedit/media-server-go-native.svg?branch=master)](https://travis-ci.org/notedit/media-server-go-native)

media server native code 




## Install 

You should install `libtool` and `autoconf` `automake` before you build 


On ubuntu
```sh
apt install autoconf
apt install libtool
apt install automake
```


On macOS

```sh
brew install libtool
brew install autoconf
brew install automake
```


Your compiler should support `c++17`, for linux, you should update your `gcc/g++` to `7.0+`

```sh
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update -qq
sudo apt-get install g++-7
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 90
```


Build the native c/c++ code,  it will install `openssl` `libsrtp` `mp4v2` `libmediaserver` into  `/usr/local`

```sh
git clone --recurse-submodules https://github.com/notedit/media-server-go-native.git  

cd media-server-go-native

make
```
