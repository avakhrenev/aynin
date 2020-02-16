import scala.util.Random

object Main {
  def main(args: Array[String]): Unit = {
  println("Hello, world!")

    val rands = (0 until 100000).map(_ => Random.self.nextInt(20): Long)
    val sum = rands.sum
    println(s"Random sum is $sum")
  }

}