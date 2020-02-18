# aynin
All you need is nix, nix. Nix is all you need.


ToDo deps is not reproducible:
hash mismatch in fixed-output derivation '/nix/store/zdld3dwpi11plaqnb44i3njgn5wfpacq-count-random-deps-0.1':
  wanted: sha256:1m308xkrdj7bmri7bw53x11l4vb3zd5hqh5gp2impw7b0h2w1krp
  got:    sha256:05xxm4xk2cdmjf5bzx420i03d56xh5hjqsy3n73mrckfbvw8fg3p
cannot build derivation '/nix/store/ijv0b859jhi0pg88jq04c0m5g1zk0x4z-count-random-0.1.drv': 1 dependencies couldn't be built
error: build of '/nix/store/ijv0b859jhi0pg88jq04c0m5g1zk0x4z-count-random-0.1.drv' failed


find . -name "*.bak" -type f -delete

vydata-0.1.50.properties

@@ -1,9 +1,9 @@
 #ivy cached data file for com.jcraft#jsch;0.1.50
-#Tue Feb 18 08:24:39 UTC 2020
+#Tue Feb 18 08:29:16 UTC 2020
 artifact\:jsch\#jar\#jar\#-929153592.is-local=false
 resolver=sbt-chain
 artifact\:jsch\#jar\#jar\#-929153592.location=https\://repo1.maven.org/maven2/com/jcraft/jsch/0.1.50/jsch-0.1.50.jar
 artifact\:ivy\#ivy\#xml\#-970018753.is-local=false
 artifact\:jsch\#pom.original\#pom\#723409070.exists=true
 artifact\:ivy\#ivy\#xml\#-970018753.location=https\://repo1.maven.org/maven2/com/jcraft/jsch/0.1.50/jsch-0.1.50.pom
 artifact\:jsch\#pom.original\#pom\#723409070.is-local=false


ToDo canonicalize jar org.scala-sbt-compiler-interface-0.13.18-bin_2.11.12__52.0.jar
remove update.log
./.ivy2/cache/org.scala-sbt/org.scala-sbt-compiler-interface-0.13.18-bin_2.11.12__52.0/jars/org.scala-sbt-compiler-interface-0.13.18-bin_2.11.12__52.0-0.13.18_20181128T115821.jar
 and
 ./.sbt/boot/scala-2.10.7/org.scala-sbt/sbt/0.13.18/org.scala-sbt-compiler-interface-0.13.18-bin_2.11.12__52.0/org.scala-sbt-compiler-interface-0.13.18-bin_2.11.12__52.0.jar