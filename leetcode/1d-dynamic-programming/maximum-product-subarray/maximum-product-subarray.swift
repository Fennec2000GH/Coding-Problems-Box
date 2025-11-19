// https://leetcode.com/problems/maximum-product-subarray/

class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var rightMax: [Int] = nums
        var rightMin: [Int] = nums

        for (i, x) in nums.enumerated().dropFirst() {
            rightMax[i] = max(x, max(rightMax[i - 1] * x, rightMin[i - 1] * x))
            rightMin[i] = min(x, min(rightMax[i - 1] * x, rightMin[i - 1] * x))
        }

        return rightMax.max()!
    }
}
