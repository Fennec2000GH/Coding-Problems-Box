// https://leetcode.com/problems/binary-search/

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left: Int = 0
        var right: Int = nums.count - 1
        var mid: Int = (left + right) / 2

        while left < right {
            mid = left + (right - left) / 2
            if nums[mid] < target {
                if left == mid {
                    mid = right
                }
                left = mid
            } else {
                right = mid
            }
        }

        return nums[mid] == target ? mid : -1
    }
}
