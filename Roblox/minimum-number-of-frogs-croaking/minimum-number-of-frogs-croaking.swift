// https://leetcode.com/problems/minimum-number-of-frogs-croaking/

class Solution {
    func minNumberOfFrogs(_ croakOfFrogs: String) -> Int {
        let n: Int = croakOfFrogs.count
        let arr: [Character] = Array(croakOfFrogs)
        var counter: [Character:Int] = [:]

        var result: Int = 0
        var numStarted: Int = 0
        for c in arr {
            counter[c] = counter[c, default: 0] + 1
            switch c {
                case "c":
                    numStarted += 1
                    result = max(result, numStarted)
                case "r":
                    guard let cnt: Int = counter["c"], cnt > 0 else {
                        return -1
                    }
                    counter["c"]! -= 1
                case "o":
                    guard let cnt: Int = counter["r"], cnt > 0 else {
                        return -1
                    }
                    counter["r"]! -= 1
                case "a":
                    guard let cnt: Int = counter["o"], cnt > 0 else {
                        return -1
                    }
                    counter["o"]! -= 1
                case "k":
                    guard let cnt: Int = counter["a"], cnt > 0 else {
                        return -1
                    }
                    counter["a"]! -= 1
                    numStarted -= 1
                default:
                    ()
            }
        }

        for (c, cnt) in counter {
            if cnt == 0 {
                counter.removeValue(forKey: c)
            }
        }
        counter.removeValue(forKey: "k")

        if !counter.isEmpty {
            return -1
        }

        return result
    }
}
