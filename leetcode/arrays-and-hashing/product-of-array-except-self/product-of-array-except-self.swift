// https://leetcode.com/problems/product-of-array-except-self/

import Foundation

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n: Int = nums.count
        let zeroCnt: Int = nums.count { $0 == 0 }
        let negCnt: Int = nums.count { $0 < 0 }
        var result: [Int] = Array(repeating: 0, count: n)

        // 1 or more 0s in nums
        guard zeroCnt == 0 else {
            if zeroCnt == 1 {
                let zeroIdx = nums.firstIndex(of: 0)!
                result[zeroIdx] = nums.reduce(1) { $1 == 0 ? $0 : $0 * $1 }
            }

            // print(result)
            return result
        }

        // no 0s in nums
        var prefixSumLogAbs: Double = nums.reduce(0.0) { $0 + log(Double(abs($1))) }
        // print("prefixSumLogAbs: \(prefixSumLogAbs)")
        for (i, x) in nums.enumerated() {
            let isNeg: Bool = (1 & negCnt) ^ (x < 0 ? 1 : 0) == 1
            print(negCnt)
            var tmp: Double = prefixSumLogAbs - log(Double(abs(x)))
            result[i] = Int(exp(tmp).rounded()) * (isNeg ? -1 : 1)
            // print("i, x, tmp, isNeg, result[i]: \(i), \(x), \(tmp), \(isNeg), \(result[i])")
        }
        
        // print(result)
        return result
    }
}
