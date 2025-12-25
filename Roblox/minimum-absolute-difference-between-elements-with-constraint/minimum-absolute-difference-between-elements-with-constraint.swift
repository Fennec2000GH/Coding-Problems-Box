// https://leetcode.com/problems/minimum-absolute-difference-between-elements-with-constraint/

class Solution {
    func binarySearch(_ nums: [Int], _ x: Int) -> Int {
        guard !nums.isEmpty else {
            return -1
        }

        let n: Int = nums.count
        var left: Int = 0
        var right: Int = n - 1
        var mid: Int = -1

        // edge case: beyond array
        if x < nums.first! {
            return 0
        } else if x > nums.last! {
            return n
        }

        while right - left > 1 {
            mid = (left + right) / 2

            if nums[mid] < x {
                left = mid
            } else {
                right = mid
            }
        }

        if nums[left] > x {
            return left
        }

        return right
    }

    func minAbsoluteDifference(_ nums: [Int], _ x: Int) -> Int {
        let n: Int = nums.count
        guard n >= 2 else {
            return 0
        }

        var result: Int = 1000000000
        var prefixArr: [Int] = [2000000000]
        var binIdx: Int = -1
        for i in x..<n {
            // find binary search index for new element
            binIdx = max(0, binarySearch(prefixArr, nums[i - x]))
            prefixArr.insert(nums[i - x], at: binIdx)

            binIdx = binarySearch(prefixArr, nums[i])
            if prefixArr[binIdx] == nums[i] {
                return 0
            } else {
                result = min(result, prefixArr[binIdx] - nums[i])
            }
            
            if binIdx >= 1 {
                result = min(result, nums[i] - prefixArr[binIdx - 1])
            }

            if x == i {
                prefixArr.dropLast()
            }
        }

        return result
    }
}
