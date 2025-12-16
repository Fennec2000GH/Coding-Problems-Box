// https://leetcode.com/problems/subarray-sum-equals-k/

import Algorithms

class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        let n: Int = nums.count
        var left: Int = 0
        var right: Int = 1
        var result: Int = 0

        let prefixSum: [Int] = Array(nums.reductions(+))
        var counter: [Int:Int] = [:]
        counter[0] = 1

        for (i, ps) in prefixSum.enumerated() {
            let num: Int = nums[i]
            result += counter[ps - k, default: 0]
            counter[ps] = counter[ps, default: 0] + 1
        }

        return result
    }
}
