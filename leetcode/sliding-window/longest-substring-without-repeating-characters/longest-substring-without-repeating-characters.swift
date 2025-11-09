// https://leetcode.com/problems/longest-substring-without-repeating-characters/

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var left: Int = 0
        var right: Int = 0
        var maxLen: Int = 0

        // maps seen character to most recent index up to current index
        // key existing does not necessarily mean in window
        var seen: [Character:Int] = [:]

        let s_arr: [Character] = Array(s)
        let n: Int = s.count

        while right < n {
            var curr: Character = s_arr[right]
            if let idx: Int = seen[curr], idx >= left {
                // all dict values < left become invalid
                left = idx + 1
            }
            seen[curr] = right
            right += 1
            maxLen = max(maxLen, right - left)
        }

        return maxLen
    }
}
