// https://leetcode.com/problems/word-break/

import Algorithms

class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let n: Int = s.count
        let s_: [Character] = Array(s)
        let wordLen: [Int] = Array(wordDict.map { $0.count }.uniqued())
        let wordSet: Set<String> = Set(wordDict)
        var dp: [Bool] = Array(repeating: false, count: n + 1)
        dp[0] = true

        for pos in 1...n {
            for len in wordLen {
                if len > pos {
                    continue
                }
                let substr: String = String(s_[(pos - len)...(pos - 1)])
                if wordSet.contains(substr), dp[pos - len] {
                    dp[pos] = true
                }
            }
        }

        return dp.last!
    }
}
