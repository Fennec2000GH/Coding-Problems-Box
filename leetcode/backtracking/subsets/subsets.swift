// https://leetcode.com/problems/subsets/

import Algorithms

class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        let n: Int = nums.count
        var result: [[Int]] = [[]]
        for k in 1...n {
            result.append(contentsOf: Array(nums.combinations(ofCount: k).map { Array($0) }))
        }
        // print(result)
        return result
    }
}
