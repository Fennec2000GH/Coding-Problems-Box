// https://leetcode.com/problems/min-cost-climbing-stairs/

class Solution {
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        let n: Int = cost.count
        var minCost: [Int] = Array(repeating: 0, count: n + 1)
        for i in 2...n {
            minCost[i] = min(minCost[i - 2] + cost[i - 2], minCost[i - 1] + cost[i - 1])
        }

        return minCost.last!
    }
}
