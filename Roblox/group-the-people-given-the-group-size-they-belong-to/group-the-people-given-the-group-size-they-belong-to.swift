// https://leetcode.com/problems/group-the-people-given-the-group-size-they-belong-to/

import Algorithms

class Solution {
    func groupThePeople(_ groupSizes: [Int]) -> [[Int]] {
        var sizeToPerson: [Int:[Int]] = Dictionary(uniqueKeysWithValues: zip(groupSizes.uniqued(), [[]].cycled()))

        var result: [[Int]] = []
        for (i, sz) in groupSizes.enumerated() {
            sizeToPerson[sz]!.append(i)
            if let group: [Int] = sizeToPerson[sz], group.count == sz {
                result.append(group)
                sizeToPerson[sz]!.removeAll()
            }
        }

        return result
    }
}
