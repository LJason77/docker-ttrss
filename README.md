# Tiny Tiny RSS 容器 #

适用于树莓派的 Tiny Tiny RSS 容器。

## 编译并运行 ##

```bash
git clone --depth=1 https://github.com/LJason77/docker-ttrss.git
cd docker-ttrss
# 更改 TTRSS_SELF_URL_PATH 为目标域名或 ip（必须）
vi files/config.php
# 更改数据库挂载路径 volumes：（如果需要）
vi docker-compose.yml
docker-compose up -d
```

## 通过代理连接 ##

如果需要通过代理连接网络，运行：

```bash
docker exec -it ttrss vi tt-rss/config.php
```

并取消最后一行的 `TTRSS_HTTP_PROXY` 注释并修改代理地址。
