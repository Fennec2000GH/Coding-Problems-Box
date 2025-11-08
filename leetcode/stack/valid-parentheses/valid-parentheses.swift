// https://leetcode.com/problems/valid-parentheses/

class Solution {
    func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        let mapper: [Character:Character] = [
            "(":")", 
            "{":"}", 
            "[":"]",
        ]

        for c in s {
            if let _: Character = mapper[c] {
                stack.append(c)
            } else if let top = stack.popLast() {
                if mapper[top] != c {
                    return false
                }
            } else {
                return false
            }
        }

        return stack.isEmpty
    }
}
