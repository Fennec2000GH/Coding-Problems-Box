// https://leetcode.com/problems/unique-paths/

class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 1, n > 1 else {
            return 1
        }

        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
        for c in 1..<n {
            dp[0][c] = 1
        }
        for r in 1..<m {
            dp[r][0] = 1
        }
        
        for r in 1..<m {
            for c in 1..<n {
                dp[r][c] = dp[r][c - 1] + dp[r - 1][c]
            }
        }

        return dp[m - 1][n - 1]
    }
}

// Solution using combinations formula, DOES NOT work for large m, n due to integer overflow
// class Solution {
//     func uniquePaths(_ m: Int, _ n: Int) -> Int {
//         guard m > 1, n > 1 else {
//             return 1
//         }

//         let primes: [Int] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
//         let m_: Int = max(m, n) - 1
//         let n_: Int = min(m, n) - 1
//         let num_fact: [Int] = Array((m_+1)...(m_+n_))
//         let denom_fact: [Int] = Array(1...n_)
//         let len: [Int] = max(num_fact.count, denom_fact.count)

//         if num_fact.count < len {
//             num_fact.append(contentsOf: Array(repeating: 1, count: len - num_fact.count))
//         } else if denom_fact.count < len {
//             denom_fact.append(contentsOf: Array(repeating: 1, count: len - denom_fact.count))
//         }

//         var num: Int = 1
//         var denom: Int = 1

//         for (num_x, denom_x) in zip(num_fact, denom_fact) {
//             for prime in primes {
//                 if prime > min(num, denom) {
//                     break
//                 }
//                 while (num % prime) + (denom % prime) == 0 {
//                     num /= prime
//                     denom /= prime
//                 }
//             }
//         }

//         return num
//     }
// }
