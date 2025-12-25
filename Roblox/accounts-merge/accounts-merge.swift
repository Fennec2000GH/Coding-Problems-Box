// https://leetcode.com/problems/accounts-merge/
// WIP, some test cases failing

import Algorithms

class Solution {
    func accountsMerge(_ accounts: [[String]]) -> [[String]] {
        let n: Int = accounts.count
        var parent: [Int] = Array(0..<n)
        var mapper: [String:Int] = [:]

        func getParent(_ i: Int) -> Int {
            var parent_: Int = i
            while parent_ != parent[i] {
                parent_ = parent[parent_]
            }

            return parent_
        }

        for (i, arr) in accounts.enumerated() {
            print(String(repeating: "-", count: 20))
            print(i, arr)
            let emails: [String] = Array(arr.dropFirst())
            let parent_grp: [Int] = Array(emails.compactMap { mapper[$0] }.uniqued().map { getParent($0) }.uniqued()) + [i]
            let min_parent: Int = parent_grp.min()!
            for parent_ in parent_grp {
                parent[parent_] = min_parent 
            }

            // note that earlier emails with same parent (known as of now) may not have been updated yet, so we find final parents at the end
            for email in emails {
                mapper[email] = min_parent
            }

            print(mapper)
        }

        var result: [[String]] = Array(repeating: [], count: n)
        for (email, parent_) in mapper {
            let final_parent: Int = getParent(parent_)
            result[final_parent].append(email)
        }

        result = Array(
            result
            .enumerated()
            .filter { !$0.1.isEmpty }
            .map { [accounts[$0.0].first!] + Array($0.1.uniqued().sorted()) }
        )

        return result
    }
}
