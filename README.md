# Tiny Tiny RSS 容器 #

适用于树莓派的 Tiny Tiny RSS 容器。

## 编译并运行 ##

```bash
git clone https://github.com/LJason77/docker-ttrss.git
cd docker-ttrss
# 更改数据库挂载路径 volumes：（如果需要）
vi docker-compose.yml
docker-compose up -d
```

## 继承数据库 ##

如果不需要初始化数据库，运行：

```bash
docker exec -it ttrss cp config.php tt-rss/
```

如果想要手动配置，具体参数可以查看：

```bash
docker exec -it ttrss cat config.php
```

## 通过代理连接 ##

如果需要通过代理连接网络，运行：

```bash
docker exec -it ttrss vi tt-rss/config.php
```

并取消最后一行的 `_HTTP_PROXY` 注释。
