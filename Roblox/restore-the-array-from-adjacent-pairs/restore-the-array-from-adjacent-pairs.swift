// https://leetcode.com/problems/restore-the-array-from-adjacent-pairs/

import Algorithms

class Solution {
    func restoreArray(_ adjacentPairs: [[Int]]) -> [Int] {
        let n: Int = adjacentPairs.count
        guard n >= 2 else {
            return adjacentPairs.first!
        }

        var nbrs: [Int:[Int]] = Dictionary<Int, [Int]>(uniqueKeysWithValues: zip(adjacentPairs.joined().uniqued(), [[]].cycled()))
        for pair in adjacentPairs {
            nbrs[pair.first!]!.append(pair.last!)
            nbrs[pair.last!]!.append(pair.first!)
        }

        var result: [Int] = [nbrs.keys.first(where: { nbrs[$0]!.count == 1 })!]
        var next: Int = nbrs[result.last!]!.first!
        for _ in 1...n {
            if let newNext: Int = nbrs[next]!.first, newNext != result.last! {
                result.append(next)
                next = newNext
            } else if let newNext: Int = nbrs[next]!.last {
                result.append(next)
                next = newNext
            } else {
                result.append(next)
            }
        }

        return result
    }
}
