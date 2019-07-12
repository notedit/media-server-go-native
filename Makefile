export ROOT_DIR=${PWD}

include config.mk

ifeq ($(DEBUG),yes)
	TAG=debug
else
	TAG=release
endif

TARGET_LIB = $(ROOT_DIR)/media-server/bin/$(TAG)/libmediaserver.a

all:ssl srtp mp4 mediaserver
	echo $(ROOT_DIR)


clean:
	cd ${ROOT_DIR}/openssl && make clean
	cd ${ROOT_DIR}/libsrtp && make clean
	cd ${ROOT_DIR}/mp4v2 && make clean
	cd ${ROOT_DIR}/media-server && rm -rf build  && rm -rf bin

ssl:
	cd ${ROOT_DIR}/openssl &&  export KERNEL_BITS=64 && ./config --prefix=/usr/local/ --openssldir=/usr/local/ && make && sudo make install 
	cd $(ROOT_DIR)

srtp:
	cd ${ROOT_DIR}/libsrtp && ./configure --prefix=/usr/local/ --enable-openssl  --with-openssl-dir=/usr/local/  && make && sudo make install 
	cd $(ROOT_DIR) 

mp4:
	cd ${ROOT_DIR}/mp4v2 && autoreconf -i && ./configure --prefix=/usr/local/ && make && sudo make install
	cd $(ROOT_DIR)

mediaserver:
	cp config.mk  ./media-server/ && make -C media-server libmediaserver.a  &&  sudo cp $(TARGET_LIB)  /usr/local/lib/libmediaserver.a 
	echo ${ROOT_DIR}

install:
	cd ./openssl/ && make install 
	cd ./libsrtp/ && make install 
	cd ./mp4v2/ && make install 
	cp ./media-server/bin/release/libmediaserver.a /usr/local/lib/

echo:
	echo $(ROOT_DIR)

