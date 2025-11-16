// https://leetcode.com/problems/climbing-stairs/

class Solution {
    func climbStairs(_ n: Int) -> Int {
        guard n >= 3 else {
            return n
        }

        var a: Int = 1
        var b: Int = 1
        var c: Int = 2

        for _ in 1...(n - 2) {
            a = b
            b = c
            c = a + b
        }

        return c
    }
}
