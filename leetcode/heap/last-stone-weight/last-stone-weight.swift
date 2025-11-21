// https://leetcode.com/problems/last-stone-weight/

import HeapModule

class Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {
        var maxHeap: Heap<Int> = Heap<Int>(stones)
        while maxHeap.count > 1 {
            let stone1: Int = maxHeap.popMax()!
            let stone2: Int = maxHeap.popMax()!
            guard stone1 > stone2 else {
                continue
            }
            maxHeap.insert(stone1 - stone2)
        }

        if let lastStone: Int = maxHeap.popMax() {
            return lastStone
        }

        return 0
    }
}
