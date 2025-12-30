// https://leetcode.com/problems/minimum-operations-to-write-the-letter-y-on-a-grid/

class Solution {
    func minimumOperationsToWriteY(_ grid: [[Int]]) -> Int {
        let n: Int = grid.count
        let y_n: Int = 3 * (n / 2) + 1

        var y_counter: [Int] = [0, 0, 0]
        var non_y_counter: [Int] = [0, 0, 0]

        for r in 0..<n {
            for c in 0..<n {
                let x: Int = grid[r][c]

                // cell belongs to Y
                if ((r - c == 0 || r + c == n - 1) && r <= n / 2) || (r > n / 2 && c == n / 2) {
                    y_counter[x] += 1
                } else {
                    non_y_counter[x] += 1
                }
            }
        }

        var result: Int = 2500
        for y_val in 0...2 {
            for non_y_val in 0...2 {
                if non_y_val == y_val {
                    continue
                }

                let y_cost: Int = y_n - y_counter[y_val]
                let non_y_cost: Int = (n*n - y_n) - non_y_counter[non_y_val]
                result = min(result, y_cost + non_y_cost)
            }
        }

        return result
    }
}
