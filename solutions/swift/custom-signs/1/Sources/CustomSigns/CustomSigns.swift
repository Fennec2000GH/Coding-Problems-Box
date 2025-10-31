// TODO: define the 'birthday' String constant
let birthday: String = "Birthday"
// TODO: define the 'valentine' String constant
let valentine: String = "Valentine's Day"
// TODO: define the 'anniversary' String constant
let anniversary: String = "Anniversary"
// TODO: define the 'space' Character constant
let space: Character = " "
// TODO: define the 'exclamation' Character constant
let exclamation: Character = "!"
func buildSign(for occasion: String, name: String) -> String {
  "Happy \(occasion) \(name)!"
}

func graduationFor(name: String, year: Int) -> String {
  "Congratulations \(name)!\nClass of \(year)"
}

func costOf(sign: String) -> Int {
  20 + 2 * sign.count
}
