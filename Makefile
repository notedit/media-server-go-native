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
	cd ./openssl && make clean
	cd ./libsrtp && make clean
	cd ./mp4v2 && make clean
	cd ./media-server && rm -rf build  && rm -rf bin && rm $(PREFIX)lib/libmediaserver.a

ssl:
	cd ./openssl &&  export KERNEL_BITS=64 && ./config --prefix=$(PREFIX) --openssldir=$(PREFIX) && make && sudo make install 

srtp:
	cd ./libsrtp && ./configure --prefix=$(PREFIX) --enable-openssl  --with-openssl-dir=$(PREFIX)  && make && sudo make install  

mp4:
	cd ./mp4v2 && autoreconf -i && ./configure --prefix=$(PREFIX) && make && sudo make install 

mediaserver:
	cp media-Makefile  ./media-server/Makefile
	cp config.mk  ./media-server/ && make -C media-server libmediaserver.a &&  sudo cp ./media-server/bin/release/libmediaserver.a  $(PREFIX)lib/


install:
	cd ./openssl/ && make install 
	cd ./libsrtp/ && make install 
	cd ./mp4v2/ && make install 
	cp ./media-server/bin/release/libmediaserver.a $(PREFIX)lib

echo:
	echo $(ROOT_DIR)

