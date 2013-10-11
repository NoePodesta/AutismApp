import sbt._
import Keys._
import play.Project._

object ApplicationBuild extends Build {

  val appName         = "AutismApplication"
  val appVersion      = "1.0-SNAPSHOT"


  val appDependencies = Seq(
    "commons-io" % "commons-io" % "2.3",
    jdbc,
    javaCore,
    javaEbean,
   "mysql" % "mysql-connector-mxj" % "5.0.12",
    "com.typesafe" %% "play-plugins-mailer" % "2.1-RC2"
  )


  val main = play.Project(appName, appVersion, appDependencies).settings(
    // Add your own project settings here
  )

}
