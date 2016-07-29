### Up and running quickly with Docker

```bash
$ docker run -w /app -v $PWD:/app swiftdocker/swift make
```

*Voila!* You are inside the container, running your automated tests
with the latest version of swift!
Note that your local folder is mounted,
so any changes you make outside of docker will be available here as well.
