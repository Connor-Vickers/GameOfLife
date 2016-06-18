### Up and running quickly with Docker

```bash
docker run -it -w /app -v $PWD:/app --privileged=true swiftdocker/swift bash
```

*Voila!* You are inside the container with the latest version of swift!
Note that your local folder is mounted,
so any changes you make outside of docker will be available here as well.
From here you can use the package manager and the REPL as you would expect.

Here's a one-liner to get started with Speck:
```bash
swift build && .build/debug/Specs
```
