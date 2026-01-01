// https://leetcode.com/problems/regular-expression-matching/

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let s_: [Character] = Array(s)
        let p_: [Character] = Array(p)
        let s_n: Int = s_.count
        let p_n = p_.count
        var memo: [[Bool?]] = Array(repeating: Array(repeating: nil, count: p_n + 1), count: s_n + 1)

        func fillMemo(_ sIdx: Int, _ pIdx: Int) -> Bool {
            guard pIdx < p_n else {
                return sIdx == s_n
            }

            if let isValid: Bool = memo[sIdx][pIdx] {
                return isValid
            }

            var isMatchFound: Bool = false
            let noStarCheck: Bool = sIdx < s_n && (s_[sIdx] == p_[pIdx] || p_[pIdx] == ".")
          
            // when current pattern neighbors '*' to the right
            if pIdx + 1 < p_n, p_[pIdx + 1] == "*" {
                // option 1 - interpret (char)* as empty string (skipping this 2-char pattern)
                isMatchFound = fillMemo(sIdx, pIdx + 2)

                // option 2 - use this 2-char pattern 1 or more times
                if !isMatchFound, noStarCheck { 
                    isMatchFound = fillMemo(sIdx + 1, pIdx)
                }
            }
            // no (char)* detected for current char in pattern
            else if noStarCheck {
                isMatchFound = fillMemo(sIdx + 1, pIdx + 1)
            }
            memo[sIdx][pIdx] = isMatchFound
          
            return isMatchFound
        }
      
        return fillMemo(0, 0)
    }
}
