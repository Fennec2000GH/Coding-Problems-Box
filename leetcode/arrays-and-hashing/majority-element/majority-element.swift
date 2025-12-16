// https://leetcode.com/problems/majority-element/

class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var result: Int = nums.first!
        var count: Int = 0
        for num in nums {
            if num != result {
                count -= 1
                if count == -1 {
                    count = 0
                    result = num
                }
            } else {
                count += 1
            }
        }

        return result
    }
}
