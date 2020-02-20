# aynin
All you need is nix, nix. Nix is all you need.



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
