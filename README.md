# s3fs并发测试容器

测试单bucket在s3fs的场景下，可以同时挂载多少个客户端，并同时往里复制数据

## 容器变量

|变量名|解释|
|-----|----|
|TEST_URL |并发开关，只有服务有效返回200时，任务才会执行，保证所有容器都启动后，再让此服务有效|
|BUCKET_NAME|桶的名称|
|ACCESS_KEY_ID|key|
|SECRET_ACCESS_KEY|安全key|
|S3_URL|s3url|
|TEST_FILE|复制的源文件路径，由于文件很大，在容器内不产生文件，使用数据卷或着映射的方式进容器内|

## 运行

### 本地手动运行

启动容器，请更换路径和IP地址，IP地址为docker0的IP

```shell
docker run -it -v /home/joelin/tm/s3fs:/data  \
      -e TEST_URL=http://172.17.0.1:8081/ \
      -e BUCKET_NAME=testbk     \
      -e ACCESS_KEY_ID=0555b35654ad1656d804   \
      -e SECRET_ACCESS_KEY=h7GhxuBLTrlhVUyxSPUKUV8r/2EI4ngqJxD7iBdBYLhwluN30JaT3Q==   \
      -e S3_URL=http://172.17.0.1:8000/ \
      -e TEST_FILE=/data/testfile \
      --cap-add SYS_ADMIN \
      --privileged \
      s3fstest
```

开启web服务，让数据复制启动。

>python -m SimpleHTTPServer 8081

检查 s3对象桶里面是否有文件？