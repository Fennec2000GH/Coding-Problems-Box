// https://leetcode.com/problems/number-of-black-blocks/

class Solution {
    func countBlackBlocks(_ m: Int, _ n: Int, _ coordinates: [[Int]]) -> [Int] {
        var blackBox: Set<[Int]> = Set<[Int]>(coordinates)
        var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)

        var result: [Int] = Array(repeating: 0, count: 5)
        guard !coordinates.isEmpty else {
            result[0] = (m - 1) * (n - 1)
            return result
        }

        // maps each diagonal from black element to lower right corner of corresponding 2x2 block
        let offsetToBlock: [[Int]:[Int]] = Dictionary(uniqueKeysWithValues: zip(
            [[-1, 1], [-1, -1], [1, -1], [1, 1]], 
            [[0, 1], [0, 0], [1, 0], [1, 1]]
        ))

        // counts number of black elements within each 2x2 block, ID'ed by lower right corner
        var infectedBlocks: [[Int]:Int] = [:]
        for loc in coordinates {
            let r: Int = loc[0]
            let c: Int = loc[1]

            for (offset, blockOffset) in offsetToBlock {
                let newCoord: (Int, Int) = (r + offset[0], c + offset[1])
                if newCoord.0 >= 0, newCoord.0 < m, newCoord.1 >= 0, newCoord.1 < n {
                    infectedBlocks[[r + blockOffset[0], c + blockOffset[1]]] = infectedBlocks[[r + blockOffset[0], c + blockOffset[1]], default: 0] + 1
                }
            }
        }

        for (block, cnt) in infectedBlocks {
            result[cnt] += 1
        }
        result[0] = (m - 1) * (n - 1) - infectedBlocks.count

        return result
    }
}
