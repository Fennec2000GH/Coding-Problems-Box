// https://leetcode.com/problems/break-a-palindrome/
class Solution {
    func breakPalindrome(_ palindrome: String) -> String {
        let n: Int = palindrome.count
        var s_: [Character] = Array(palindrome)
        
        // edge cases
        guard n > 1 else {
            return ""
        }
        guard palindrome != String(repeating: "a", count: n) else {
            return String(s_.dropLast() + ["b"])
        }

        // at this point, palindrome has at least 1 non-"a" letter
        var idx: Int = s_.firstIndex(where: { $0 != "a" })!
        
        // odd length palindrome with center as the only non-"a" letter
        if idx == n / 2, n % 2 == 1 {
            return String(s_.dropLast() + ["b"])
        } else {
            s_[idx] = "a"
        }

        return String(s_)
    }
}
