export ROOT_DIR=${PWD}

include config.mk

ifeq ($(DEBUG),yes)
	TAG=debug
else
	TAG=release
endif

all:ssl srtp mp4 mediaserver
	echo $(ROOT_DIR)

ssl:
	cd ${ROOT_DIR}/openssl &&  export KERNEL_BITS=64 && ./config  && make && sudo make install 
	cd $(ROOT_DIR)

srtp:
	cd ${ROOT_DIR}/libsrtp && ./configure && make && sudo make install 
	cd $(ROOT_DIR) 

mp4:
	cd ${ROOT_DIR}/mp4v2 && autoreconf -i && ./configure && make && sudo make install
	cd $(ROOT_DIR)

mediaserver:
	cp config.mk  ./media-server/ && make -C media-server libmediaserver.a 
	echo ${ROOT_DIR}

echo:
	echo $(ROOT_DIR)