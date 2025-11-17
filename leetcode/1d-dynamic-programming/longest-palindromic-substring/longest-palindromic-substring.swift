// https://leetcode.com/problems/longest-palindromic-substring/

class Solution {
    func longestPalindrome(_ s: String) -> String {
        var s_: [Character] = [Character("#")]
        for x in s {
            s_.append(contentsOf: [x, Character("#")])
        }

        let n: Int = s_.count
        var radii: [Int] = Array(repeating:0, count: n)
        var center: Int = 0
        var rBound: Int = 0

        for (i, x) in s_.enumerated() {
            let mirrorIdx: Int = center << 1 - i;

            if i < rBound {
                radii[i] = min(rBound - i, radii[mirrorIdx]);
            }

            while i + 1 + radii[i] < n,
                i - 1 - radii[i] >= 0,
                s_[i + 1 + radii[i]] == s_[i - 1 - radii[i]] {
                radii[i] += 1
            }

            if i + radii[i] > rBound {
                center = i;
                rBound = i + radii[i];
            }
        }

        var maxLen: Int = 0;
        var centerIdx: Int = 0;
        for (i, radius) in radii.enumerated() {
            if radius > maxLen {
                maxLen = radius
                centerIdx = i;
            }
        }

        let startIdx: Int = (centerIdx - maxLen) / 2;
        return String(Array(s)[startIdx..<(startIdx + maxLen)])
    }
}
