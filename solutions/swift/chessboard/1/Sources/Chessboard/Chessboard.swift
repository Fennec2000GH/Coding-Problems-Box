// TODO: define the 'ranks' constant
let ranks: ClosedRange<Int> = 1...8

// TODO: define the 'files' constant
let files: ClosedRange<String> = "A"..."H"

func isValidSquare(rank: Int, file: String) -> Bool {
  ranks.contains(rank) && files.contains(file)
}

func getRow(_ board : [String], rank: Int) -> [String] {
  let rowSize: Int = ranks.count
  let i: Int = (rowSize * (rank - 1))
  return Array(board[i..<(i+rowSize)])
}
