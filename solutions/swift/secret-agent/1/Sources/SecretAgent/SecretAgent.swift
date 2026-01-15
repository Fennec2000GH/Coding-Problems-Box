func protectSecret(_ secret: String, withPassword password: String) -> (String) -> String {
    func f(_ pass: String) -> String {
      pass == password ? secret : "Sorry. No hidden secrets here."
    }
  return f
}

func generateCombination(forRoom room: Int, usingFunction f: (Int) -> Int) -> (Int, Int, Int) {
  var x: Int = room
  var ret: (Int, Int, Int) = (0, 0, 0)

  x = f(x)
  ret.0 = x
  x = f(x)
  ret.1 = x
  x = f(x)
  ret.2 = x
  
  return ret
}
