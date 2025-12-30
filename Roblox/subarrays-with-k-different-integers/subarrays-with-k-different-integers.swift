// https://leetcode.com/problems/subarrays-with-k-different-integers/

class Solution {
    // for index j, find smallest i < j such that any subarray in nums[i...j] has at most k distinct elements
    func leftWinIdx(_ nums: [Int], _ k: Int) -> [Int] {
        let n: Int = nums.count
        var arr: [Int] = Array(repeating: 0, count: n)
        var counter: [Int:Int] = [:]

        var left: Int = 0
        for right in 0..<n {
            var x: Int = nums[right]
            counter[x] = counter[x, default: 0] + 1
            while counter.count > k {
                x = nums[left]
                counter[x]! -= 1
                if counter[x] == 0 {
                    counter.removeValue(forKey: x)
                }
                left += 1
            }

            arr[right] = left
        }
      
        return arr
    }

    func subarraysWithKDistinct(_ nums: [Int], _ k: Int) -> Int {
        let n: Int = nums.count
        let leftWinIdxK: [Int] = leftWinIdx(nums, k)
        let leftWinIdxKM1 = leftWinIdx(nums, k - 1)
        var result: Int = zip(leftWinIdxKM1, leftWinIdxK).map {$0 - $1}.reduce(0, +)

        return result
    }
}
