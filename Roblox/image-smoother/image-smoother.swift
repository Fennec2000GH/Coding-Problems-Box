// https://leetcode.com/problems/image-smoother/

import Algorithms

class Solution {
    func filter(_ img: [[Int]], _ r: Int, _ c: Int) -> Int {
        let m: Int = img.count
        let n: Int = img.first!.count

        var sum: Int = 0
        var validCnt: Int = 0

        let deltas: [(Int, Int)] = Array(product([-1, 0, 1], [-1, 0, 1]))
        for delta in deltas {
            let idx: (Int, Int) = (r + delta.0, c + delta.1)
            if idx.0 >= 0, idx.0 <= m - 1, idx.1 >= 0, idx.1 <= n - 1 {
                sum += img[idx.0][idx.1]
                validCnt += 1
            }
        }
        
        return sum / validCnt
    }

    func imageSmoother(_ img: [[Int]]) -> [[Int]] {
        let m: Int = img.count
        let n: Int = img.first!.count

        var result: [[Int]] = img
        for r in 0..<m {
            for c in 0..<n {
                result[r][c] = filter(img, r, c)
            }
        }

        return result
    }
}
