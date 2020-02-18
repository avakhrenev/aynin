name := "random-sum"
enablePlugins(ScalaNativePlugin)
scalaVersion := "2.11.12"
nativeMode := "release"
// use immix by default, but we may link with boehm
// nativeGC := "boehm"