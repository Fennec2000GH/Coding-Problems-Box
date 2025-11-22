// https://leetcode.com/problems/kth-largest-element-in-an-array/

import Algorithms
import HeapModule

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let n: Int = nums.count
        guard k < n else {
            return nums.min()!
        }

        let counter: [Int:Int] = nums.reduce(into: [:]) { counts, x in counts[x, default: 0] += 1 }
        var maxHeap: Heap<Int> = Heap<Int>(nums.uniqued())

        var cntLeft = k
        while let max: Int = maxHeap.popMax() {
            cntLeft -= counter[max]!
            if cntLeft <= 0 {
                return max
            }
        }

        // should never reach here
        return -1
    }
}
