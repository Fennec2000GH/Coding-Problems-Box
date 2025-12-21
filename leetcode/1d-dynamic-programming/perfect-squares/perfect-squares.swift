// https://leetcode.com/problems/perfect-squares/

class Solution {
    func numSquares(_ n: Int) -> Int {
        guard n >= 4 else { 
            return n
        }

        var dp: [Int] = Array(0...n)
        for base in 2...Int(floor(Double(n).squareRoot())) {
            for i in 1...n {
                let factor: Int = i / (base * base)
                dp[i] = min(dp[i], dp[i - factor * base * base] + factor)
            }
        }

        return dp.last!
    }
}
