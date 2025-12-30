// https://leetcode.com/problems/diagonal-traverse/

class Solution {
    func findDiagonalOrder(_ mat: [[Int]]) -> [Int] {
        let m: Int = mat.count
        let n: Int = mat[0].count
        
        var result: [Int] = []
        var northeast: Bool = true
        for diag in 0...(m + n - 2) {
            var pos: (Int, Int) = (0, 0)
            
            // set up starting position in diagonal
            if northeast {
                pos = (min(m - 1, diag), diag - min(m - 1, diag))
            } else {
                pos = (diag - min(n - 1, diag), min(n - 1, diag))
            }

            repeat {
                result.append(mat[pos.0][pos.1])
                pos.0 += (northeast ? -1 : 1)
                pos.1 += (northeast ? 1 : -1)
            } while pos.0 >= 0 && pos.0 < m && pos.1 >= 0 && pos.1 < n
            northeast = !northeast
        }

        return result
    }
}
