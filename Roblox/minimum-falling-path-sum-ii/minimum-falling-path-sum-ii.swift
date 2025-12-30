// https://leetcode.com/problems/minimum-falling-path-sum-ii/
// WIP: most test cases pass except for very large and obscure inputs

class Solution {
    func minFallingPathSum(_ grid: [[Int]]) -> Int {
        let n: Int = grid.count
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)

        // indices for smallest and second smallest elements from previous row
        // value for min1 is always smaller than min2 
        var prevMin1: Int = -1
        var prevMin2: Int = -1
        for c in 0..<n {
            let x: Int = grid[0][c]
            dp[0][c] = x
            if prevMin2 == -1 || x < dp[0][prevMin2] {
                if prevMin1 == -1 || x < dp[0][prevMin1] {
                    prevMin2 = prevMin1
                    prevMin1 = c
                } else {
                    prevMin2 = c
                }
            }
        }

        for r in 1..<n {
            // same indices but for ongoing row being processed
            var currMin1: Int = -1
            var currMin2: Int = -1

            for c in 0..<n {
                dp[r][c] = dp[r - 1][c == prevMin1 ? prevMin2 : prevMin1] + grid[r][c]

                let x: Int = dp[r][c]
                if currMin2 == -1 || x < currMin2 {
                    if currMin1 == -1 || x < currMin1 {
                        currMin2 = currMin1
                        currMin1 = c
                    } else {
                        currMin2 = c
                    }
                }
            }
            prevMin1 = currMin1
            prevMin2 = currMin2

            print("r: \(r)")
            print(dp[r])
        }

        return dp[n - 1].min()!
    }
}
