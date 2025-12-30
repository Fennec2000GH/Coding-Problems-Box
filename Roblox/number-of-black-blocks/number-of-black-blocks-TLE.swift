// https://leetcode.com/problems/number-of-black-blocks/
// Time complexity: O(MN), TLE, 2103 / 2145 testcases passed

class Solution {
    func countBlackBlocks(_ m: Int, _ n: Int, _ coordinates: [[Int]]) -> [Int] {
        var blackBox: Set<[Int]> = Set<[Int]>(coordinates)
        var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)

        var result: [Int] = Array(repeating: 0, count: 5)
        let deltas: [(Int, Int)] = [(0, 1), (1, 1), (1, 0)]

        for r in 0..<m {
            for c in 0..<n {
                if blackBox.contains([r, c]) { 
                    grid[r][c] += 1

                    // update southeast corner element
                    for delta in deltas {
                        let newCoord: (Int, Int) = (r + delta.0, c + delta.1)
                        if newCoord.0 < m, newCoord.1 < n {
                            grid[newCoord.0][newCoord.1] += 1
                        }
                    }
                }

                if r >= 1, c >= 1 {
                    result[grid[r][c]] += 1
                }
            }
        }

        return result
    }
}
