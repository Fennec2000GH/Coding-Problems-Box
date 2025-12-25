// https://leetcode.com/problems/spiral-matrix-ii/

class Solution {
    func generateMatrix(_ n: Int) -> [[Int]] {
        let size: Int = n * n
        var result: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
        var curr: (Int, Int) = (0, 0)
        var delta: (Int, Int) = (0, 1)

        for i in 1...size {
            result[curr.0][curr.1] = i
            if !(curr.0 + delta.0 >= 0 &&
                curr.0 + delta.0 <= n - 1 && 
                curr.1 + delta.1 >= 0 &&
                curr.1 + delta.1 <= n - 1 &&
                result[curr.0 + delta.0][curr.1 + delta.1] == 0)
            {
                switch delta {
                    case (0, 1):
                        delta = (1, 0)
                    case (1, 0):
                        delta = (0, -1)
                    case (0, -1):
                        delta = (-1, 0)
                    case (-1, 0):
                        delta = (0, 1)
                    default:
                        ()    
                }
            }

            curr = (curr.0 + delta.0, curr.1 + delta.1)
        }

        return result
    }
}
