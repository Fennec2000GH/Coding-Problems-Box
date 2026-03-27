// TODO: define the 'remainingMinutesInOven' function
func remainingMinutesInOven(elapsedMinutes: Int, expectedMinutesInOven: Int = 40) -> Int {
  expectedMinutesInOven - elapsedMinutes
}

// TODO: define the 'preparationTimeInMinutes' function
func preparationTimeInMinutes(layers: String...) -> Int {
  2 * layers.count
}

// TODO: define the 'quantities' function
func quantities(layers: String...) -> (noodles: Int, sauce: Double) {
  let numNoodles: Int = layers.count(where: { $0 == "noodles" })
  let numSauce: Int = layers.count(where: { $0 == "sauce" })
  return (noodles: 3 * numNoodles, sauce: 0.2 * Double(numSauce))
}

// TODO: define the 'toOz' function
func toOz(_ amount: inout (noodles: Int, sauce: Double)) {
  amount.sauce *= 33.814
}

// TODO: define the 'redWine' function
func redWine(layers: String...) -> Bool {
  var counterDict: [String: Int] = [:]
  for layer in layers {
    counterDict[layer, default: 0] += 1
  }

  let numCheese: Int = counterDict["mozzarella", default: 0] + counterDict["ricotta", default: 0] + counterDict["béchamel", default: 0]
  let numMS: Int = counterDict["meat", default: 0] + counterDict["sauce", default: 0]
  if numCheese > numMS {
    return false
  }
  return true
}