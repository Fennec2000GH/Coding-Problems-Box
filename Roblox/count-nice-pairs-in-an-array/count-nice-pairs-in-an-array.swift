// https://leetcode.com/problems/count-nice-pairs-in-an-array/

import Foundation

class Solution {
    let MOD: Int = Int(pow(10.0, 9)) + 7
    func rev(_ x: Int) -> Int {
        Int(String(String(x).reversed()))!
    }

    func countNicePairs(_ nums: [Int]) -> Int {
        var result: Int = 0
        var counter: [Int:Int] = [:]
        for x in nums {
            let target: Int = x - rev(x)
            if let cnt: Int = counter[target] {
                result = (result + cnt) % MOD
                counter[target]! += 1
            } else {
                counter[target] = 1
            }
        }

        return result
    }
}

