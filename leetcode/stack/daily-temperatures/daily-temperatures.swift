// https://leetcode.com/problems/daily-temperatures/

class Solution {
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        let n: Int = temperatures.count
        var stack: [Int] = [] // stores indexes, not elements
        var result: [Int] = Array(repeating: 0, count: n)

        for (i, x) in temperatures.enumerated() {
            while let top: Int = stack.last, temperatures[top] < x {
                result[top] = i - top
                stack.removeLast()
            }
            stack.append(i)
        }

        return result
    }
}
