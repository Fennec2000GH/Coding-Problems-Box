// https://leetcode.com/problems/maximum-number-of-occurrences-of-a-substring/

class Solution {
    func maxFreq(_ s: String, _ maxLetters: Int, _ minSize: Int, _ maxSize: Int) -> Int {
        // just need to check window of minSize, since most frequent substring also contains min-sized substring with same frequency
        let n: Int = s.count
        let s_: [Character] = Array(s)
        var charCounter: [Character:Int] = [:]
        var strCounter: [String:Int] = [:]

        // initialize counter for first window
        for c in s_.prefix(minSize - 1) {
            charCounter[c] = charCounter[c, default: 0] + 1
        }

        var left: Int = 0
        for right in (minSize - 1)..<n {
            let c: Character = s_[right]
            charCounter[c] = charCounter[c, default: 0] + 1

            while charCounter.count > maxLetters {
                let c: Character = s_[left]

                charCounter[c]! -= 1
                if charCounter[c] == 0 {
                    charCounter.removeValue(forKey: c)
                }
                left += 1
            }
            if right - left + 1 == minSize {
                let str: String = String(s_[left...right])
                strCounter[str] = strCounter[str, default: 0] + 1

                let c: Character = s_[left]
                charCounter[c]! -= 1
                if charCounter[c] == 0 {
                    charCounter.removeValue(forKey: c)
                }

                left += 1
            }
        }

        if strCounter.isEmpty {
            return 0
        }

        return strCounter.values.max()!
    }
}
