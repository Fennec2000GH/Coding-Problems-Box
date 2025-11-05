// https://leetcode.com/problems/group-anagrams/ 

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [String:[String]] = [:]
        for str in strs {
            let key: String = String(str.sorted())
            if groups.contains { $0.key == key } {
                groups[key]!.append(str)
            } else {
                groups [key] = [str]
            }
        }

        return Array(groups.map { (_, group) in group })
    }
}