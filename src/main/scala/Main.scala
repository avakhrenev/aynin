import scala.util.Random

object Main {
  def main(args: Array[String]): Unit = {
    val max = 1000000
    println(s"Hello, let me sum ${max} random numbers!")
    val rands = (0 until max).map(_ => Random.self.nextInt(20): Long)
    val sum = rands.sum
    println(s"Random sum is $sum")

    println(s"Let's also check regexp")
    import scala.util.matching.Regex

    val numberPattern: Regex = "[0-9]".r

    numberPattern.findFirstMatchIn("awesomepassword") match {
      case Some(_) => println("Impossible")
      case None => println("Ok, we've done regexp.")
    }
  }

}
