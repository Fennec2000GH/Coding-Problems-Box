// https://leetcode.com/problems/sum-of-all-subset-xor-totals/

class Solution {
    func subsetXORSum(_ nums: [Int]) -> Int {
        let n: Int = nums.count
        var result: Int = 0
        for num in nums {
            result |= num
        }

        return result << (n - 1)
    }
}
