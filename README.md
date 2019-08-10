# Tiny Tiny RSS 容器 #

基于最新的 alpine 镜像。

## 安装 ##

### 方法一 ###

```bash
git clone https://github.com/LJason77/docker-ttrss.git
cd docker-ttrss
docker build -t docker-ttrss .
```

### 方法二 ###

```bash
docker pull ljason/docker-ttrss
```

## 运行 ##

默认端口为 3000，如需更改端口，请把下面命令中的 `--network host` 改为 -p 8080:3000，即为 8080 端口，以此类推。同时 `SELF_URL_PATH` 也需改为相应端口，如：`http://192.168.1.100:8080`。

`/var/lib/postgresql/data` 为数据库目录，如需备份请按照下面命令在自己的目录挂载，否则可去掉此参数。

`SELF_URL_PATH` 为访问地址，改为实际地址，如：`http://example.com:3000/ttrss` 或者 `http://192.168.1.100:3000`。

```bash
# 方法一安装
docker run -d --restart always --name ttrss -v /your/TTRss/Data:/var/lib/postgresql/data --network host -e SELF_URL_PATH=http://ip:3000 docker-ttrss
# 方法二安装
docker run -d --restart always --name ttrss -v /your/TTRss/Data:/var/lib/postgresql/data --network host -e SELF_URL_PATH=http://ip:3000 ljason/docker-ttrss
```
