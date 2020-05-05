version := "0.1"
name := "tiny-tests"

scalaVersion := "2.12.11"

scalacOptions ++= Seq("-deprecation", "-feature", "-unchecked", "-language:reflectiveCalls")

// Chisel snapshots and releases are found here:
//
// https://github.com/ucb-bar/chisel3/releases
// https://github.com/ucb-bar/chisel-testers/releases
val defaultVersions = Map(
  "chisel3" -> "3.3.0",
)

libraryDependencies ++= (Seq("chisel3").map { dep: String =>
  "edu.berkeley.cs" %% dep % sys.props
    .getOrElse(dep + "Version", defaultVersions(dep)) withSources () withJavadoc ()
})

resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases")
)
