#!/bin/bash

mkdir -p /var/s3fs/test

modprobe fuse

if [ x${TEST_URL} != 'x' ] && [ x${BUCKET_NAME} != 'x' ] && [ x${ACCESS_KEY_ID} != 'x' ] && [ x${SECRET_ACCESS_KEY} != 'x' ] && [ x${S3_URL} != 'x' ];then

  echo ${ACCESS_KEY_ID}:${SECRET_ACCESS_KEY} > /etc/passwd-s3fs
  chmod 600 /etc/passwd-s3fs

  s3fs ${BUCKET_NAME} /var/s3fs/test -o passwd_file=/etc/passwd-s3fs -o url=${S3_URL} -o use_path_request_style
  
  while [ 1=1 ]
  do 
    RCODE=`curl -I -m 10 -o /dev/null -s -w %{http_code} ${TEST_URL}`
    if [ x${RCODE} = 'x200' ];then
     if [ -f ${TEST_FILE} ];then
       cp ${TEST_FILE} /var/s3fs/test 
     else 
       echo "test file is not exits"
     fi
    exit 0
    else 
      echo "return code is not 200"
    fi
  done
else 
  echo "param not exits"
fi
