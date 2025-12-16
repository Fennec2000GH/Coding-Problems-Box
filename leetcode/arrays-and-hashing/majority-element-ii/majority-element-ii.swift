// https://leetcode.com/problems/majority-element-ii/

class Solution {
    func majorityElement(_ nums: [Int]) -> [Int] {
        var cand1: Int = 1000000000 + 1
        var cand2: Int = cand1
        var count1: Int = 0
        var count2: Int = 0
        for num in nums {
            if cand1 == num {
                count1 += 1
            } else if cand2 == num {
                count2 += 1
            } else if count1 == 0 {
                count1 = 1
                cand1 = num
            } else if count2 == 0 {
                count2 = 1
                cand2 = num
            } else {
                count1 -= 1
                count2 -= 1
            }
        }
        
        let n: Int = nums.count
        var result: [Int] = []
        if nums.count { $0 == cand1 } > n / 3 {
            result.append(cand1)
        }
        if nums.count { $0 == cand2 } > n / 3 {
            result.append(cand2)
        }

        return result
    }
}
