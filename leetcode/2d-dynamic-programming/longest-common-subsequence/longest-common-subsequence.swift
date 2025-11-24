// https://leetcode.com/problems/longest-common-subsequence/

class Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let m: Int = text1.count
        let n: Int = text2.count
        let text1_: [Character] = Array(text1)
        let text2_: [Character] = Array(text2)

        guard m > 1, n > 1 else {
            if text1.count == 1 {
                return text2_.contains(text1_.first!) ? 1 : 0
            }
            return text1_.contains(text2_.first!) ? 1 : 0
        }

        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        dp[0][0] = text1_.first! == text2_.first! ? 1 : 0
        for c in 1..<n {
            if dp[0][c - 1] == 1 || text1_.first! == text2_[c] {
                dp[0][c] = 1
            }
        }
        for r in 1..<m {
            if dp[r - 1][0] == 1 || text2_.first! == text1_[r] {
                dp[r][0] = 1
            }
        }
        
        for r in 1..<m {
            for c in 1..<n {
                dp[r][c] = max(dp[r][c - 1], dp[r - 1][c])
                if text1_[r] == text2_[c] {
                    dp[r][c] = max(dp[r - 1][c - 1] + 1, dp[r][c])
                }
            }
        }

        return dp[m - 1][n - 1]
    }
}
