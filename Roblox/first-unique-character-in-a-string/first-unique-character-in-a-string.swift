// https://leetcode.com/problems/first-unique-character-in-a-string/

import OrderedCollections

class Solution {
    func firstUniqChar(_ s: String) -> Int {
        let n: Int = s.count
        let s_: [Character] = Array(s)
        var good: OrderedDictionary<Character, Int> = [:]
        var bad: Set<Character> = []

        for (i, char) in s_.enumerated() {
            if bad.contains(char) {
                continue
            }
            if let _: Int = good[char] {
                good.removeValue(forKey: char)
                bad.insert(char)
                continue
            }
            good.updateValue(i, forKey: char)
        }

        if good.isEmpty {
            return -1
        }

        return good.removeFirst().value
    }
}
