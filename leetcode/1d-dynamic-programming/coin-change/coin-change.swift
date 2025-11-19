// https://leetcode.com/problems/coin-change/

class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard amount >= 1 else {
            return 0
        }

        let inf: Int = 10000 + 1
        var dp: [Int] = Array(repeating: inf, count: amount + 1)
        dp[0] = 0
        
        for denom in coins {
            if denom > amount {
                continue
            }
            for (i, curr) in dp.enumerated().dropFirst(denom) {
                let prevIdx: Int = i - denom
                let alt: Int = 1 + dp[prevIdx]
                dp[i] = min(curr, alt)
            }
        }

        guard let last: Int = dp.last, last < inf else { 
            return -1
        }
        return dp.last!
    }
}
