# mc.yohane.su

![](https://github.com/sk2sat/mc.yohane.su/actions/workflows/build-image.yml/badge.svg?branch=main)
![](https://img.shields.io/docker/image-size/sksat/mc.yohane.su)

my minecraft server

## setup & start

Deploy Machine
```sh
$ ./setup.sh
$ docker-compose up -d
```

Server Machine(mc.yohane.su)
```sh
$ cp minecraft-expose.service ~/.config/systemd/user
$ systemctl enable --user --now minecraft-expose.service
```

## maintenance

```sh
$ ./cmd.sh say hello
```

or use [mcrcon](https://github.com/Tiiffi/mcrcon)

## how to join

Edit [whitelist.json](https://github.com/sksat/mc.yohane.su/blob/main/data/whitelist.json) and send a pull request
