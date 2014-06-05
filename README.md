docker-orthanc
==============

Docker container for [Orthanc](http://orthanc-server.com), a lightweight DICOM server

### Build

    sudo docker build  -rm -t <user>/orthanc git://github.com/merky/docker-orthanc.git

### Run

You'll need to modify `example-config.json` and place it within `/some/path/`.

    docker run -d -p 8042:8042 -p 4242:4242 \
               -v /some/path:/data <user>/orthanc /data/your-config.json

