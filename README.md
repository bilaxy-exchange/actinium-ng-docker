# actinium-ng-docker

Pull from Docker Hub and run with Tor enabled:

```bash
docker run -it -e "RPCUSER=myusername" -e "RPCPASSWORD=mypassword" -e "RPCALLOWIP=127.0.0.1" -e "TORENABLED=1" brakmic/actinium-ng
```

or without Tor:

```bash
docker run -it -e "RPCUSER=myusername" -e "RPCPASSWORD=mypassword" -e "RPCALLOWIP=127.0.0.1" -e "TORENABLED=0" brakmic/actinium-ng
```

To build it locally run:

```bash
docker build .
```
