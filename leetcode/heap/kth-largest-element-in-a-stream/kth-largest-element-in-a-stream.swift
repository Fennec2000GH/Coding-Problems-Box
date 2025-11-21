// https://leetcode.com/problems/kth-largest-element-in-a-stream/

import HeapModule

class KthLargest {
    var heap: Heap<Int> = []
    var k_: Int = 0
    var oneShort: Bool = false

    init(_ k: Int, _ nums: [Int]) {
        k_ = k
        heap = Heap<Int>(nums.prefix(k))
        if heap.count == k - 1 {
            oneShort = true
        }

        for x in nums.dropFirst(k) {
            add(x)
        }
    }
    
    func add(_ val: Int) -> Int {
        if oneShort {
            oneShort = false
            heap.insert(val)
            return heap.min!
        }

        if let min: Int = heap.min, val > min {
            heap.popMin()
            heap.insert(val)
        }

        return heap.min!
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */
 