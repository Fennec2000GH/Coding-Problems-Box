// https://leetcode.com/problems/subdomain-visit-count/

import Algorithms

class Solution {
    func subdomainVisits(_ cpdomains: [String]) -> [String] {
        var counter: [String:Int] = [:]

        for (cnt, domain) in cpdomains.map { $0.split(separator: " ") }.map { (Int($0.first!)!, $0.last!) } {
            let parts: [String] = Array(domain.split(separator:".").reversed().map { String($0) })
            for subdomain in parts.dropFirst().reductions(parts.first!, { String("\($1).\($0)") })     {
                counter[subdomain] = counter[subdomain, default: 0] + cnt
            }
        }

        return Array(counter.map { String("\($1) \($0)") })
    }
}
