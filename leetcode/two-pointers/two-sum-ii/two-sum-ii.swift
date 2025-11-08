// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/

class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left: Int = 0
        var right: Int = numbers.count - 1
        var sum: Int = 0

        repeat {
            sum = numbers[left] + numbers[right]
            if sum > target {
                right -= 1
            } else if sum < target {
                left += 1
            }
        } while sum != target

        return [left + 1, right + 1]
    }
}
