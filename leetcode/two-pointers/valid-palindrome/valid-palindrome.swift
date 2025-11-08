// https://leetcode.com/problems/valid-palindrome/

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        var left = s.startIndex
        var right = s.index(before: s.endIndex)
        let regex = /[^a-zA-Z0-9]/

        while s.distance(from: left, to: right) > 0 {
            while let _ = try? regex.wholeMatch(in: String(s[left])) {
                // print("skipping left: \(s[left])")
                left = s.index(after: left)
                if left == s.endIndex {
                    return true
                }
            }
            while let _ = try? regex.wholeMatch(in: String(s[right])) {
                // print("skipping right: \(s[right])")
                right = s.index(before: right)
                if right == s.startIndex {
                    return true
                }
            }

            // print("left and right valid chars: \(s[left]), \(s[right])")
            if s[left].lowercased() != s[right].lowercased() {
                return false
            }
            left = s.index(after: left)
            right = s.index(before: right)
        }

        return true
    }
}
