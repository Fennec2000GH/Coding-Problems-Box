func getCard(at index: Int, from stack: [Int]) -> Int {
  stack[index]
}

func setCard(at index: Int, in stack: [Int], to newCard: Int) -> [Int] {
  if index >= stack.count || index < 0 {
    return stack
  }

  var _stack: [Int] = stack
  _stack[index] = newCard
  return _stack
}

func insert(_ newCard: Int, atTopOf stack: [Int]) -> [Int] {
  var _stack: [Int] = stack
  _stack.append(newCard)
  return _stack
}

func removeCard(at index: Int, from stack: [Int]) -> [Int] {
  if index >= stack.count || index < 0 {
    return stack
  }

  var _stack: [Int] = stack
  _stack.remove(at: index)
  return _stack
}

func insert(_ newCard: Int, at index: Int, from stack: [Int]) -> [Int] {
  if index > stack.count || index < 0 {
    return stack
  }

  var _stack: [Int] = stack
  if index == stack.count {
    _stack.append(newCard)
  } else {
    _stack.insert(newCard, at: index)
  }
  return _stack
}

func checkSizeOfStack(_ stack: [Int], _ size: Int) -> Bool {
  stack.count == size
}
