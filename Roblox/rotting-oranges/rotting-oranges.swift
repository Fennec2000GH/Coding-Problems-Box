// https://leetcode.com/problems/rotting-oranges/

import DequeModule

class Solution {
    func orangesRotting(_ grid: [[Int]]) -> Int {
        var grid_: [[Int]] = grid
        let m: Int = grid_.count
        let n: Int = grid_[0].count

        var timeCnt: Int = -1 // initial rotten oranges does not count as time step
        var freshCnt: Int = 0
        var q: Deque<(Int, Int)> = []

        for r in 0..<m {
            for c in 0..<n {
                if grid_[r][c] == 1 {
                    freshCnt += 1
                } else if grid_[r][c] == 2 {
                    q.append((r, c))
                }
            }
        }
        
        let deltas: [(Int, Int)] = [(0, 1),(-1, 0),(0, -1),(1, 0)]
        var prevSz: Int = q.count
        var currSz: Int = 0
        while !q.isEmpty {
            for _ in 1...prevSz {
                let next: (Int, Int) = q.popFirst()!

                for delta in deltas {
                    let loc: (Int, Int) = (min(max(0, next.0 + delta.0), m - 1), min(max(0, next.1 + delta.1), n - 1))
                    if grid_[loc.0][loc.1] == 1 {
                        grid_[loc.0][loc.1] = 2
                        currSz += 1
                        freshCnt -= 1
                        q.append(loc)
                    }
                }
            }

            prevSz = currSz
            currSz = 0
            timeCnt += 1
        }

        guard freshCnt == 0 else {
            return -1
        }

        return max(0, timeCnt)
    }
}
