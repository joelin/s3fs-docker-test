FROM centos:7.2.1511

LABEL MAINTAINER = "linxuhua"

RUN yum -y install automake fuse fuse-devel gcc-c++ git libcurl-devel libxml2-devel make openssl-devel \
    && git clone https://github.com/s3fs-fuse/s3fs-fuse.git \
    && cd s3fs-fuse \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install 

COPY docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]

