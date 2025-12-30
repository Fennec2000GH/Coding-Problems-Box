// https://leetcode.com/problems/rotating-the-box/

class Solution {
    func rotateTheBox(_ boxGrid: [[Character]]) -> [[Character]] {
        let m: Int = boxGrid.count
        let n: Int = boxGrid.first!.count
        var obsLoc: [(Int, Int)] = []
        var obsLoad: [Int] = []

        var cnt: Int = 0
        for r in 0..<m {
            for c in 0..<n {
                let char: Character = boxGrid[r][c]
                if char == "#" {
                    cnt += 1
                } else if char == "*" {
                    obsLoc.append((r, c))
                    obsLoad.append(cnt)
                    cnt = 0
                }
            }

            // handle left overs tones that fall to bottom of rotated grid
            if cnt > 0 {
                obsLoc.append((r, n))
                obsLoad.append(cnt)
                cnt = 0
            }
        }
        
        // rotate box
        var result: [[Character]] = Array(repeating: Array(repeating: ".", count: m), count: n)
        for (loc, load) in zip(obsLoc, obsLoad) {
            let rotated: (Int, Int) = (loc.1, m - 1 - loc.0)
            
            // not a dummy obstacle at bottom of rotated box
            if rotated.0 < n {
                result[rotated.0][rotated.1] = "*"
            }

            if load > 0 {
                for offset in 1...load {
                    result[rotated.0 - offset][rotated.1] = "#"
                }
            }
        }

        return result
    }
}
