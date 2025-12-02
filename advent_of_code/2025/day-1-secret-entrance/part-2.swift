
import Foundation

let file: String = "./input.txt"
var curr: Int = 50
var zeroCount: Int = 0

do {
	let input = try String(contentsOfFile: file, encoding: .utf8)
	let lines = input.split(separator: "\n").map { String($0) }

	for line in lines {
		// print(line)
		let delta: Int = Int(String(Array(line).dropFirst()))!
		zeroCount += (delta / 100)
		// print("delta: \(delta), curr: \(curr)")
		if line.starts(with: "L") {
			if delta % 100 >= curr, curr != 0 {
				zeroCount += 1
			}
			curr = ((curr - delta) % 100 + 100) % 100
		} else if line.starts(with: "R") {
			if delta % 100 >= (100 - curr), curr != 0 {
				zeroCount += 1
			}
			curr = (curr + delta) % 100
		}
		// print("new curr: \(curr), zeroCount: \(zeroCount)")
	}
} catch {
	// print("Error reading file: \(error)")
}

print("solution: \(zeroCount)")
