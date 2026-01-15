func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String {
  let monthlyCost: Double = price / (5 * 12)
  if monthlyBudget >= monthlyCost {
    return "Yes! I'm getting a \(vehicle)"
  } else if monthlyBudget * (1.10) >= monthlyCost {
    return "I'll have to be frugal if I want a \(vehicle)"
  } 
  return "Darn! No \(vehicle) for me"
}

func licenseType(numberOfWheels wheels: Int) -> String {
  if [2, 3].contains(wheels) {
    return "You will need a motorcycle license for your vehicle"
  } else if [4, 6].contains(wheels) {
    return "You will need an automobile license for your vehicle"
  } else if wheels == 18 {
    return "You will need a commercial trucking license for your vehicle"
  }
  return "We do not issue licenses for those types of vehicles"
}

func calculateResellPrice(originalPrice: Int, yearsOld: Int) -> Int {
  var discountFactor: Double = 1.0
  switch yearsOld {
    case 0..<3:
      discountFactor = 0.80
    case 3..<10:
      discountFactor = 0.70
    default:
      discountFactor = 0.50
  }
  return Int(Double(originalPrice) * discountFactor)
}
