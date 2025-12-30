// https://leetcode.com/problems/count-the-number-of-good-subarrays/

class Solution {
    func countGood(_ nums: [Int], _ k: Int) -> Int {
        let n: Int = nums.count

        guard (n * (n - 1)) >> 1 >= k else {
            return 0
        }

        guard n >= 3 else {
            return (n - 1) * (nums.first! == nums.last! ? 1 : 0)
        }

        var counter: [Int:Int] = [:]
        var eqCounter: [Int:Int] = [:]
        var eqCnt: Int = 0

        var result: Int = 0
        var left: Int = 0
        for (right, x) in nums.enumerated() {
            // print("----------")
            // print("left, right: \(left), \(right)")

            counter[x] = counter[x, default: 0] + 1
            eqCounter[x] = eqCounter[x, default: 0] + counter[x]! - 1
            eqCnt += counter[x]! - 1

            // print("phase 1 counters")
            // print(counter)
            // print(eqCounter)
            // print(eqCnt)

            while eqCnt >= k {
                result += n - right
                // print("new result: \(result)")

                let left_x: Int = nums[left]
                counter[left_x]! -= 1
                eqCounter[left_x]! -= counter[left_x]!
                eqCnt -= counter[left_x]!
                left += 1
            }

            // print("phase 2 counters")
            // print(counter)
            // print(eqCounter)
            // print(eqCnt)
        }

        return result
    }
}
