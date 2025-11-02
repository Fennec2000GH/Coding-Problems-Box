import Foundation

/*
 * Complete the 'fairRations' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts INTEGER_ARRAY B as parameter.
 */

func fairRations(B: [Int]) -> String {
    let oddIndexes: [Int] = Array(B.enumerated().filter { (i: Int, e: Int) in e % 2 == 1 }.map { (i: Int, _: Int) in i })

    if oddIndexes.count % 2 == 1 {
        return "NO"
    }

    var cnt: Int = 0;
    for i in stride(from: 1, to: oddIndexes.count, by: 2) {
        cnt += oddIndexes[i] - oddIndexes[i - 1] 
    }

    return String(cnt * 2)
}

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let N = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

guard let BTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let B: [Int] = BTemp.split(separator: " ").map {
    if let BItem = Int($0) {
        return BItem
    } else { fatalError("Bad input") }
}

guard B.count == N else { fatalError("Bad input") }

let result = fairRations(B: B)

fileHandle.write(result.data(using: .utf8)!)
fileHandle.write("\n".data(using: .utf8)!)
