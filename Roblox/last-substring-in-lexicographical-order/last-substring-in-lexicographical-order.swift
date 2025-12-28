// https://leetcode.com/problems/last-substring-in-lexicographical-order/

class Solution {
    func lastSubstring(_ s: String) -> String {
        let n: Int = s.count
        let s_: [Character] = Array(s)
        var bestIdx: Int = 0

        var cIdx: Int = 1
        var offset: Int = 0
        while cIdx + offset < n {
            // continue matching, as current best substring and candidate substrin are equal so far
            if (s_[bestIdx + offset] == s_[cIdx + offset]) {
                offset += 1
            } else if s_[bestIdx + offset] < s_[cIdx + offset] {
                // candidate substring beats current best substring
                bestIdx += offset + 1
                offset = 0

                if bestIdx >= cIdx {
                    cIdx = bestIdx + 1
                }
            } else {
                // current best substring beats candidate, move to new candidate
                cIdx += offset + 1
                offset = 0
            }
        }
      
        return String(s_[bestIdx...])
    }
}
