

// https://leetcode.com/problems/sliding-window-maximum/

import DequeModule

class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        // setting up initial deque
        // left, right indexes are inclusive
        var window: Deque<Int> = [] // stores indexes, not elements
        for i in 0..<k {
            while let backIdx: Int = window.last, nums[backIdx] <= nums[i] {
                window.popLast()
            }
            window.append(i)
        }

        var result: [Int] = [nums[window.first!]]
        
        // "right" acts as right end of window and time step
        // note that window is never empty at any time step at start of loop
        for (right, x) in nums.enumerated().dropFirst(k) {
            let left: Int = right - k + 1
            if let frontIdx: Int = window.first, frontIdx < left {
                window.popFirst() // previous left no longer relevant
            }

            while let backIdx: Int = window.last, nums[backIdx] <= nums[right] {
                window.popLast()
            }
            window.append(right)
            result.append(nums[window.first!])
        }

        return result
    }
}
