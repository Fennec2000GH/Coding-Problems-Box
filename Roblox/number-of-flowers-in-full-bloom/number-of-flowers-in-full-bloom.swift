// https://leetcode.com/problems/number-of-flowers-in-full-bloom/

class Solution {
    func fullBloomFlowers(_ flowers: [[Int]], _ people: [Int]) -> [Int] {
        var startTs: [Int] = flowers.map { $0.first! }.sorted()
        var endTs: [Int] = flowers.map { $0.last! }.sorted()

        // binary search
        func bisectLeft(_ nums: [Int], _ target: Int) -> Int {
            var left: Int = 0
            var right: Int = nums.count - 1
            var idx = nums.count

            while (left <= right) {
                var mid: Int = left + (right - left) >> 1
                if nums[mid] >= target {
                    idx = mid
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            }
            return idx
        }

        var result: [Int] = []
        for pTs in people {
            var fStarted: Int = bisectLeft(startTs, pTs + 1)
            var fEnded: Int = bisectLeft(endTs, pTs)
            result.append(fStarted - fEnded)
        }

        return result
    }
}
