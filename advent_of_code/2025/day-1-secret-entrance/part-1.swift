
import Foundation

let file: String = "./input.txt"
var curr: Int = 50
var zeroCount: Int = 0

do {
	let input = try String(contentsOfFile: file, encoding: .utf8)
	let lines = input.split(separator: "\n").map { String($0) }
	for line in lines {
		let delta: Int = Int(String(Array(line).dropFirst()))!
		if line.starts(with: "L") {
			curr = (curr - delta) % 100 + 100) % 100
		} else if line.starts(with: "R") {
			curr = (curr + delta) % 100
		}
		if curr == 0 {
			zeroCount += 1
		}
	}
} catch {
	print("Error reading file: \(error)")
}

print("solution: \(zeroCount)")
