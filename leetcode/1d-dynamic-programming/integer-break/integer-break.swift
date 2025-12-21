// https://leetcode.com/problems/integer-break/

import Foundation

class Solution {
    func integerBreak(_ n: Int) -> Int {
        var result: Int = 1
        switch n {
            case 2:
                return 1
            case 3: 
                return 2
            default:
                var n_: Int = n
                while(n_ > 4) {
                    result *= 3
                    n_ -= 3
                }
                result *= n_
        }
        
        return result
    }
}
