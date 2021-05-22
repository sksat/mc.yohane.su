# mc.yohane.su

![](https://github.com/sk2sat/mc.yohane.su/actions/workflows/build-image.yml/badge.svg?branch=main)
![](https://img.shields.io/docker/image-size/sksat/mc.yohane.su)
![](https://img.shields.io/uptimerobot/status/m787979705-dedee70ce3309167bafdd585?label=Port%20Status)
![mc.yohane.su](https://img.shields.io/endpoint?url=https%3A%2F%2Fminecraft-server-status-badge.vercel.app%2Fapi%2Fserver%2Fmc.yohane.su%3Fport%3D25565)

my minecraft server

- [Status Page](https://stats.uptimerobot.com/QLk7XC6Kxv)(expose server port only)

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
