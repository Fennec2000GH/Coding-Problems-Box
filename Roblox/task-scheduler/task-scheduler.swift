// https://leetcode.com/problems/task-scheduler/

class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var counter: [Character:Int] = [:]
        for c in tasks {
            counter[c] = counter[c, default: 0] + 1
        }
        let maxFreq: Int = counter.values.max()!
        let maxFreqCnt: Int = counter.values.count { $0 == maxFreq }
        let slotsCnt: Int = (maxFreq - 1) * (n + 1) + maxFreqCnt

        return max(tasks.count, slotsCnt)
    }
}
