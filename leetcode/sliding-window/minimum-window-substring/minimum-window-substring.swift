// https://leetcode.com/problems/minimum-window-substring/
// 266/268 test cases passed due to TLE

extension Dictionary where Value: Comparable {
    func isMultiSubset(of other: [Key: Value]) -> Bool {
        for (k, v) in self {
            guard let other_v = other[k], v <= other_v else {
                return false
            } 
        }
        return true
    }
}

class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        let m: Int = s.count
        let n: Int = t.count
        var s_arr: [Character] = Array(s)
        var minSubstr: String = String(repeating: "*", count: m + 1)
        guard m >= n else {
            return ""
        }

        var counter_t: [Character:Int] = [:]
        for x in t {
            counter_t[x] = counter_t[x, default: 0] + 1
        }
        // print(counter_t)

        // each charater x points to next index associated with any character in t
        var skipList: [Int] = Array(repeating: -1, count: m)
        var mostRecent: Int = -1 // index of most recently seen character in t
        for (i, x) in s_arr.enumerated() {
            if let _: Int = counter_t[x] {
                if mostRecent != -1 {
                    skipList[mostRecent] = i
                }
                mostRecent = i
            }
        }

        // fill non-t elements in skiplist that are -1, except possibly for prefix of -1s
        for (i, x) in skipList.enumerated().dropFirst() {
            if !counter_t.keys.contains { $0 == s_arr[i] }, x == -1, skipList[i - 1] != -1 {
                skipList[i] = skipList[i - 1]
            }
        }

        // fill prefix of -1s if exist
        if let first_t_idx = (0..<m).firstIndex { idx in counter_t[s_arr[idx]] != nil } {
            let idx: Int = skipList.distance(from: skipList.startIndex, to: first_t_idx)
            for i in 0..<idx {
                skipList[i] = idx
            }
        }

        // print(skipList)

        var counter_s: [Character:Int] = [:]
        var left: Int = 0
        for (right, x) in s_arr.enumerated() {
            // print(String(repeating: "-", count: 20))
            // print("left, right: \(left), \(right)")

            // only need to count in s characters in target counter
            if let _: Int = counter_t[x] {
                counter_s[x] = counter_s[x, default: 0] + 1
            }

            var satisfied: Bool = counter_t.isMultiSubset(of: counter_s)
            var winLen: Int = right - left + 1
            while satisfied, winLen >= n {
                let leftChar: Character = s_arr[left]
                // print("leftChar: \(leftChar)")

                if !counter_t.keys.contains { $0 == leftChar } {
                    left = skipList[left]
                    winLen = right - left + 1
                    continue
                }
                let leftCnt: Int = counter_s[leftChar]!

                if winLen < minSubstr.count {
                    minSubstr = String(s_arr[left...right])

                    // optimization based on forced confirmation of minimum substring
                    if winLen == n {
                        return minSubstr
                    }
                }

                if leftCnt == 1 {
                    counter_s.removeValue(forKey: leftChar)
                } else {
                    counter_s[leftChar] = leftCnt - 1
                }

                left = skipList[left]
                if left == -1 {
                    break
                }

                // prep for next iteration
                satisfied = counter_t.isMultiSubset(of: counter_s)
                winLen = right - left + 1
            }

            // print(counter_s)
        }

        return minSubstr.count == m + 1 ? "" : minSubstr
    }
}
