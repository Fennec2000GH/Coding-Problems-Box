// https://leetcode.com/problems/house-robber-ii/

class Solution {
    func rob(_ nums: [Int]) -> Int {
        let n: Int = nums.count
        guard n > 2 else { 
            return nums.max()!
        }

        var result: Int = -1
        var dp: [Int] = Array(repeating: 0, count: n)

        // force house 0 as first robbed house
        dp.replaceSubrange(0..<2, with: [nums[0], nums[0]])
        for (i, x) in nums.enumerated().dropFirst(2) {
            dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])
        }

        // means last house cannot be robbed
        dp[n - 1] = dp[n - 2]
        result = dp.last!

        // force house 0 to not be robbed
        dp.replaceSubrange(0..<2, with: [0, nums[1]])
        for (i, x) in nums.enumerated().dropFirst(2) {
            dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])
        }
        result = max(result, dp.last!)

        return result
    }
}
