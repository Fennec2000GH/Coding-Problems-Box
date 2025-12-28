// https://leetcode.com/problems/minimum-falling-path-sum/

class Solution {
    func minFallingPathSum(_ matrix: [[Int]]) -> Int {
        let n: Int = matrix.count
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
        for c in 0..<n {
            dp[0][c] = matrix[0][c]
        }

        for r in 1..<n {
            for c in 0..<n {
                dp[r][c] = min(
                    min(
                        dp[r - 1][max(0, c - 1)],
                        dp[r - 1][c]
                    ),
                    dp[r - 1][min(n - 1, c + 1)]
                ) + matrix[r][c]
            }
        }

        return dp[n - 1].min()!
    }
}
