// https://leetcode.com/problems/first-missing-positive/

class Solution {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        let n: Int = nums.count
        var nums_ : [Int] = nums

        for i in 0..<n {
            while nums_[i] > 0, nums_[i] < n, nums_[i] != nums_[nums_[i]], i != nums_[i] {
                nums_.swapAt(i, nums_[i])
            }
        }

        for i in 1..<n {
            if i != nums_[i] {
                return i
            }
        }

        return n + (nums_.first! == n ? 1 : 0)
    }
}
