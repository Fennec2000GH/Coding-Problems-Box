func dailyRateFrom(hourlyRate: Int) -> Double {
  Double(hourlyRate * 8)
}

func monthlyRateFrom(hourlyRate: Int, withDiscount discount: Double) -> Double {
  var monthlyBaseRate: Double = dailyRateFrom(hourlyRate: hourlyRate) * 22
  return (monthlyBaseRate * (100 - discount) / 100).rounded(.up)
}

func workdaysIn(budget: Double, hourlyRate: Int, withDiscount discount: Double) -> Double {
  let discountFactor: Double = (100 - discount) / 100
  let undiscountedBudget: Double = budget / discountFactor
  return (undiscountedBudget / dailyRateFrom(hourlyRate: hourlyRate)).rounded(.down)
}
