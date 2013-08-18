import sbt._
import Keys._
import play.Project._

object ApplicationBuild extends Build {

  val appName         = "AutismApplication"
  val appVersion      = "1.0-SNAPSHOT"


  val appDependencies = Seq(
    jdbc,
    javaCore,
    javaEbean,
   "mysql" % "mysql-connector-mxj" % "5.0.12"
  )


  val main = play.Project(appName, appVersion, appDependencies).settings(
    // Add your own project settings here      
  )

}
