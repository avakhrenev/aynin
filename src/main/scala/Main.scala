import scala.util.Random

object Main {
  def main(args: Array[String]): Unit = {
    val max = 1000000
    println(s"Hello, let me sum ${max} random numbers!")
    val rands = (0 until max).map(_ => Random.self.nextInt(20): Long)
    val sum = rands.sum
    println(s"Random sum is $sum")
  }

}
