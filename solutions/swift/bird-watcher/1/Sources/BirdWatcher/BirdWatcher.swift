func totalBirdCount(_ birdsPerDay: [Int]) -> Int {
  birdsPerDay.reduce(0, +)
}

func birdsInWeek(_ birdsPerDay: [Int], weekNumber: Int) -> Int {
  let i: Int = 7 * (weekNumber - 1)
  return birdsPerDay[i..<(i+7)].reduce(0, +)
}

func fixBirdCountLog(_ birdsPerDay: [Int]) -> [Int] {
  Array(birdsPerDay.enumerated().map{(i, e) in i % 2 == 1 ? e : e + 1})
}
