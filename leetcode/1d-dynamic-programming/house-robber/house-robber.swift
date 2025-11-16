// https://leetcode.com/problems/house-robber/

class Solution {
    func rob(_ nums: [Int]) -> Int {
        let n: Int = nums.count
        guard n > 2 else { 
            return nums.max()!
        }

        var dp: [Int] = Array(repeating: 0, count: n)
        dp.replaceSubrange(0..<2, with: [nums[0], max(nums[0], nums[1])])
        for (i, x) in nums.enumerated().dropFirst(2) {
            dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])
        }

        return dp.last!
    }
}
