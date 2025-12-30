// https://leetcode.com/problems/powx-n/

import Foundation

class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        guard !x.isZero, x != 1.0 else {
            return x
        }
        guard n != 0 else {
            return 1.0
        }
        guard n != 1 else {
            return x
        }

        let neg: Bool = n < 0
        
        // index i -> x^(2^i)
        var memo: [Double] = Array(repeating: 0.0, count: Int(log2(abs(Double(n)))) + 1)
        memo[0] = neg ? 1.0 / x : x
        for p in 1..<memo.count {
            memo[p] = memo[p - 1] * memo[p - 1]
        }

        var ptr: Int = memo.count - 1
        var powLeft: Int = Int(abs(Double(n)))
        var result: Double = 1.0
        while powLeft > 0 {
            result *= memo[ptr]
            powLeft -= 1 << ptr
            while 1 << ptr > powLeft {
                ptr -= 1
            }
        }

        return result
    }
}
