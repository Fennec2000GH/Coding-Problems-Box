// https://leetcode.com/problems/4sum/

class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let n: Int = nums.count
        guard n >= 4 else {
            return []
        }

        var counter: [Int:Int] = [:]
        for x in nums.dropFirst(2) {
            counter[x] = counter[x, default: 0] + 1
        }

        var result: [[Int]] = []
        var seen: Set<[Int]> = []
        for k in 2..<n {
            counter[nums[k]]! -= 1
            if let k_cnt: Int = counter[nums[k]], k_cnt == 0 {
                counter.removeValue(forKey: nums[k])
            }

            for j in 1..<k {
                for i in 0..<j {
                    let sum_3: Int = nums[i] + nums[j] + nums[k]
                    let diff: Int = target - sum_3
                    let cand: [Int] = [nums[i], nums[j], nums[k], diff]
                    if let _: Int = counter[diff], !seen.contains(cand.sorted()) {
                        result.append(cand)
                        seen.insert(cand.sorted())
                    }
                }
            }
        }
        
        result = Array(result.uniqued())
        return result
    }
}
