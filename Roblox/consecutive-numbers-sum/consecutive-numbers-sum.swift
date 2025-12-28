// https://leetcode.com/problems/consecutive-numbers-sum/
// O(N) solution but TLE for large inputs

class Solution {
    func trNumber(_ x: Int) -> Int {
        (x * (x + 1)) >> 1
    }

    func consecutiveNumbersSum(_ n: Int) -> Int {
        var result: Int = 0
        var left: Int = 0
        var right: Int = Int(ceil((-1.0 + Double(1 + n << 3).squareRoot()) / 2.0))
        while right <= n + 1 {
            while trNumber(right) - trNumber(left) > n {
                left += 1
            }
            if trNumber(right) - trNumber(left) == n {
                result += 1
            }
            right += 1
        }

        return result
    }
}

// Refernce solution adapted from: https://algo.monster/liteproblems/829

class Solution {
    func consecutiveNumbersSum(_ n: Int) -> Int {
        let n_: Int = n << 1;
        var result: Int = 0;
        var x: Int = 1

        while x*(x+1) <= n_ {
            if n_ % x == 0, (n_ / x + 1 - x) % 2 == 0 {
                result += 1
            }
            x += 1
        }
      
        return result;
    }
}
