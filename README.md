# What is it?
It is scala-native helloworld project, which doesn't require any setup besides having [nix](https://nixos.org/nix/), all
required dependencies are provided by it. Moreover, it demonstrates how to package scala-native program to nix, so it could
be used elsewhere.

```
nix-build
./result/bin/random-sum
```

To build docker image (currently works only on linux):
```
nix-build docker.nix -A layered
```

To hack on the scala project itself, use nix-shell:
```
nix-shell --command sbt
```
