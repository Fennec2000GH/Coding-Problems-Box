class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var indexer: [Int:Int] = [:]
        for (i, x) in nums.enumerated() {
            let diff: Int = target - x
            if let diff_i = indexer[diff] {
                return [diff_i, i]
            }
            indexer[x] = i
        }

        // should not reach here given problem constraints
        return []
    }
}
