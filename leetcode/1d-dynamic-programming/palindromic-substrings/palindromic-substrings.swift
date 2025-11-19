// https://leetcode.com/problems/palindromic-substrings/

class Solution {
    func countSubstrings(_ s: String) -> Int {
        let n: Int = s.count
        guard n > 1 else {
            return 1
        }

        let s_: [Character] = Array(s)
        var mat: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: n)

        for i in 0..<n {
            mat[i][i] = true
        }

        for offset in 1...(n - 1) {
            for r in 0..<(n - offset) {
                let c: Int = r + offset
                guard s_[r] == s_[c] else {
                    continue
                }
                guard c > r + 1 else {
                    mat[r][c] = true
                    continue
                }
                mat[r][c] = mat[r + 1][c - 1]
            }
        }

        return mat.flatMap { $0 }.count { $0 }
    }
}
