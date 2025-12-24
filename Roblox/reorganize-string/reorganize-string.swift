// https://leetcode.com/problems/reorganize-string/

class Solution {
    func reorganizeString(_ s: String) -> String {
        let n: Int = s.count
        let s_: [Character] = Array(s)
        var counter: [Character:Int] = [:]
        for c in s_ {
            counter[c] = counter[c, default: 0] + 1
        }
        if let maxFreq: Int = counter.values.max(), maxFreq > (n + 1) / 2 { 
            return ""
        }

        var counterRev: [Int:[Character]] = [:]
        for (c, freq) in counter {
            if !counterRev.keys.contains(where: { $0 == freq}) {
                counterRev[freq] = []
            }
            counterRev[freq]!.append(c)
        }

        var counterRevArr: [(Int, [Character])] = Array(counterRev.keys.sorted().reversed().map { (Int($0), counterRev[$0]!) })

        var result: [Character] = Array(repeating: " ", count: n)
        var idx: Int = 0
        for (freq, chars) in counterRevArr {
            for c in chars {
                var freq_: Int = freq
                while freq_ > 0 {
                    freq_ -= 1
                    result[idx] = c
                    idx += 2

                    if idx >= n {
                        idx = 1
                    }
                }
            }
        }

        return String(result)
    }
}
