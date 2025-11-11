// https://leetcode.com/problems/search-a-2d-matrix/

class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m: Int = matrix.count
        let n: Int = matrix.first!.count

        guard target >= matrix[0][0], target <= matrix[m - 1][n - 1] else {
            return false
        }

        let col: [Int] = Array((0..<m).map { matrix[$0].first! })
        print(col)

        var left: Int = 0
        var right: Int = m - 1
        var col_mid: Int = (left + right) / 2

        // binary search on first column
        while left < right {
            col_mid = left + (right - left) / 2
            if col[col_mid] < target {
                if left == col_mid {
                    col_mid = right
                }
                left = col_mid
            } else {
                right = col_mid
            }
        }

        // col binary search indexes row that comes immediately after row possibly containing target, if first element of this row does not match target
        if let x: Int = matrix[col_mid].first, x > target {
            col_mid = max(0, col_mid - 1)
        }

        print(col_mid)

        left = 0
        right = n - 1
        var row_mid: Int = (left + right) / 2

        // binary search on selected row
        let row: [Int] = matrix[col_mid]
        while left < right {
            row_mid = left + (right - left) / 2
            if row[row_mid] < target {
                if left == row_mid {
                    row_mid = right
                }
                left = row_mid
            } else {
                right = row_mid
            }
        }
        print(row_mid)

        return matrix[col_mid][row_mid] == target
    }
}
