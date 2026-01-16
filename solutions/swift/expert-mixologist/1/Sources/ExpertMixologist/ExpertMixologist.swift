func timeToPrepare(drinks: [String]) -> Double {
  var totalTime: Double = 0

  for drink in drinks {
    switch drink {
      case "beer", "soda", "water": 
        totalTime += 0.5
      case "shot":
        totalTime += 1.0
      case "mixed drink": 
        totalTime += 1.5
      case "fancy drink":
        totalTime += 2.5
      case "frozen drink":
        totalTime += 3.0
      default:
        continue
    }
  }

  return totalTime
}

func makeWedges(needed: Int, limes: [String]) -> Int {
  if needed == 0 {
    return 0
  }

  var cnt: Int = 0
  var limeCnt: Int = 0
  for lime in limes {
    switch lime {
      case "small":
        cnt += 6
      case "medium":
        cnt += 8
      case "large":
        cnt += 10
      default:
        continue
    }
      limeCnt += 1
    if cnt >= needed {
      break
    }
  }

  return limeCnt
}

func finishShift(minutesLeft: Int, remainingOrders: [[String]]) -> [[String]] {
  var ml: Double = Double(minutesLeft)
  var dropCnt: Int = 0
  for order in remainingOrders {
    let t: Double = timeToPrepare(drinks: order)
    ml -= t
    dropCnt += 1
    if ml <= 0 {
      break
    }
  }
  return Array(remainingOrders.dropFirst(dropCnt))
}

func orderTracker(orders: [(drink: String, time: String)]) -> (
  beer: (first: String, last: String, total: Int)?, soda: (first: String, last: String, total: Int)?
) {
  
  var beerT1: String = "99:99"
  var beerT2: String = "00:00"
  var beerCnt: Int = 0
  
  var sodaT1: String = "99:99"
  var sodaT2: String = "00:00"
  var sodaCnt: Int = 0
  
  for (drink, time) in orders {
    if drink == "beer" {
      beerT1 = min(beerT1, time)
      beerT2 = max(beerT2, time)
      beerCnt += 1
    } else if drink == "soda" {
      sodaT1 = min(sodaT1, time)
      sodaT2 = max(sodaT2, time)
      sodaCnt += 1
    }
  }

  return (beer: beerCnt > 0 ? (first: beerT1, last: beerT2, total: beerCnt) : nil, soda: sodaCnt > 0 ? (first: sodaT1, last: sodaT2, total: sodaCnt) : nil)
}
