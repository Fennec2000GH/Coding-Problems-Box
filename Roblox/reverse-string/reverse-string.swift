// https://leetcode.com/problems/reverse-string/

class Solution {
    func reverseString(_ s: inout [Character]) {
        let n: Int = s.count
        guard n >= 2 else {
            return
        }

        for i in 0...(n/2 - 1) {
            s.swapAt(i, n - 1 - i)
        }
    }
}
