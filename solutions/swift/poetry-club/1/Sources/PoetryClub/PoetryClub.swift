import Foundation

func splitOnNewlines(_ poem: String) -> [String] {
  poem.components(separatedBy: "\n")
}

func frontDoorPassword(_ phrase: String) -> String {
  var firstLetters: [String] = []
  for line in splitOnNewlines(phrase) {
    firstLetters.append(line.isEmpty ? "_" : String(line.prefix(1)))
  }
  return firstLetters.joined(separator: "")
}

func backDoorPassword(_ phrase: String) -> String {
  var lastLetters: [String] = []
  for line in splitOnNewlines(phrase) {
    let _line: String = line.trimmingCharacters(in: .whitespacesAndNewlines)
    if !_line.isEmpty {
      lastLetters.append(String(_line.suffix(1)))
    }
  }
  return lastLetters.joined(separator: "") + ", please"
}

func secretRoomPassword(_ phrase: String) -> String {
  var passwd: String = ""
  let lines: [String] = splitOnNewlines(phrase)
  for (i, line) in lines.enumerated() {
    if let index = line.index(line.startIndex, offsetBy: i, limitedBy: line.endIndex) {
      passwd.append(String(line[index]))
    }
  }

  return passwd.uppercased + "!"
}
