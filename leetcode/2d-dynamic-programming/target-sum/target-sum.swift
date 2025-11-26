//  https://leetcode.com/problems/target-sum/
// WIP solution in Swift. Problem depends on theoretical math knowledge, so disregard passing all edge cases.

 /**
 Find the number of ways to assign + or - signs to elements in nums to get target sum.
      
        This problem can be transformed into a subset sum problem:
        Let P be the sum of numbers with + sign, N be the sum of numbers with - sign
        P - N = target and P + N = sum(nums)
        Therefore: 2*N = sum(nums) - target, so N = (sum(nums) - target) / 2
      
        The problem becomes: find number of subsets with sum equal to N
**/

class Solution {
    func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        // solution is same for target and -target
        let t: Int = Int(abs(target))
        let sum_: Int = nums.reduce(0, +)
        let t_n: Int = (sum_ - t) / 2

        let m: Int = nums.count
        let n: Int = t_n

        // print("t_n: \(t_n)")

        if sum_ == t {
            return Int(pow(2.0, Double(nums.count{ $0 == 0})))
        }
        guard sum_ >= t, (sum_ - t) % 2 == 0 else {
            return 0
        }
        guard m > 1 else {
            return Int(abs(nums.first!)) == t ? 1 : 0
        }

        var dp: [Int] = Array(repeating: 0, count: t_n + 1)
        dp[0] = 1

        for num in nums {
            for i in (num...t_n).reversed() {
                dp[i] += dp[i - num]
            }
        }
        
        // print(dp)
        return dp.last!
    }
}
