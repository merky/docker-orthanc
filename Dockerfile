# Ubuntu 12.04 LTS
FROM ubuntu:12.04

# Update
RUN apt-get -y update

# Install everything
RUN apt-get install -y build-essential unzip cmake mercurial
RUN apt-get install -y uuid-dev libcurl4-openssl-dev liblua5.1-0-dev
RUN apt-get install -y wget libgtest-dev libpng-dev
RUN apt-get install -y libsqlite3-dev libssl-dev zlib1g-dev
RUN apt-get install -y libdcmtk2-dev libboost-all-dev libwrap0-dev

# download orthanc
WORKDIR /tmp
RUN wget https://github.com/jodogne/Orthanc/releases/download/0.7.5/Orthanc-0.7.5.tar.gz

# untar orthanc
RUN tar -xzvf Orthanc-0.7.5.tar.gz

# install orthanc
WORKDIR /tmp/Orthanc-0.7.5/
RUN cmake "-DDCMTK_LIBRARIES=wrap;oflog" -DALLOW_DOWNLOADS=ON -DUSE_SYSTEM_MONGOOSE=OFF -DUSE_SYSTEM_JSONCPP=OFF -DUSE_SYSTEM_GOOGLE_LOG=OFF -DUSE_GTEST_DEBIAN_SOURCE_PACKAGE=ON -DSTATIC_BUILD=ON .;
RUN make
RUN make install

# make our "storage area". This will be mounted when run
VOLUME /data

# expose HTTP port
EXPOSE 8042
EXPOSE 4242

# RUN orthanc
WORKDIR /
ENTRYPOINT ["Orthanc"]
CMD ["-h"]

