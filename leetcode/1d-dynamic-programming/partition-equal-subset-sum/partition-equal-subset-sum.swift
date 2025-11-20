// https://leetcode.com/problems/partition-equal-subset-sum/

class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let n: Int = nums.count
        let total: Int = nums.reduce(0, +)
        let target: Int = total / 2

        guard total % 2 == 0 else { 
            return false
        }

        var pSums: Set<Int> = Set([0])
        for x in nums {
            for sum in pSums {
                if sum + x == target {
                    return true
                }
                pSums.insert(sum + x)
            }
        }
        
        return false
    }
}
