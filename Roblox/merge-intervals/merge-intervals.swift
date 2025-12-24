// https://leetcode.com/problems/merge-intervals/

class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        let intervals_: [[Int]] = Array(intervals.sorted { $0[0] == $1[0] ? $0[1] <= $1[1] : $0[0] < $1[0] })

        var result: [[Int]] = []
        var curr: [Int] = intervals_.first!
        for ival in intervals_.dropFirst() {
            if ival[0] <= curr[1] {
                curr[0] = min(curr[0], ival[0])
                curr[1] = max(curr[1], ival[1])
            } else {
                result.append(curr)
                curr = ival
            }
        }
        result.append(curr)

        return result
    }
}
