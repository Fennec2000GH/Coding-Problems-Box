func newScoreBoard() -> [String: Int] {
  [:]
}

func addPlayer(_ scores: inout [String: Int], _ name: String, _ score: Int = 0) {
  scores[name] = score
}

func removePlayer(_ scores: inout [String: Int], _ name: String) {
  scores.removeValue(forKey: name)
}

func resetScore(_ scores: inout [String: Int], _ name: String) {
  if let _ = scores[name] {
    scores[name] = 0
  }
}

func updateScore(_ scores: inout [String: Int], _ name: String, _ delta: Int) {
  if !scores.contains(where: { $0.key == name }) {
    return
  }
  scores[name, default: 0] += delta
}

func orderByPlayers(_ scores: [String: Int]) -> [(String, Int)] {
  scores.sorted(by: <)

}

func orderByScores(_ scores: [String: Int]) -> [(String, Int)] {
  scores.sorted { $0.value > $1.value }
}
