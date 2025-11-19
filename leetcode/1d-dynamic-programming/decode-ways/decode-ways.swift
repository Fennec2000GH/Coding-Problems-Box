// https://leetcode.com/problems/decode-ways/

class Solution {
    func numDecodings(_ s: String) -> Int {
        let n: Int = s.count
        let arr: [Int] = s.map { $0.wholeNumberValue! }
        var dp: [Int] = Array(repeating: 0, count: n)
        
        if let first: Int = arr.first, first < 1 || first > 26 {
            return 0
        }

        dp[0] = 1
        for (i, x) in arr.enumerated().dropFirst() {
            if x != 0 {
                guard x >= 1, x <= 26 else {
                    return 0
                }
                dp[i] = dp[i - 1]
            } else if arr[i - 1] == 0 {
                return 0
            }

            if let alt: Int = Int(String(arr[i - 1]) + String(x)), alt <= 26, arr[i - 1] != 0 {
                dp[i] += i >= 2 ? dp[i - 2] : 1
            }
        }

        return dp.last!
    }
}
