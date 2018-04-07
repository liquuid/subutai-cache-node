You need create the cache directory structure:

`mkdir -p cache/{deb,raw,qry,tmpl}`

First you need place the ssl keys in right directory. If you don't have then generate with:

`openssl req -x509 -newkey rsa:4096 -keyout bootstrap/cdn/nginx-selfsigned.key -out bootstrap/cdn/nginx-selfsigned.crt -days 365 -nodes`

So you can build the docker image: 

`docker build -t cache-node .`

Then you can run the container:

``` 
docker run -t --tmpfs /run --tmpfs /run/lock \
      --tmpfs /tmp --cap-add SYS_ADMIN --device=/dev/fuse \
      --security-opt apparmor:unconfined  --net=host \
      -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v $PWD:/app -d -p 80:80 -p 8338:8338 -p 8080:8080 cache-node:latest
```
