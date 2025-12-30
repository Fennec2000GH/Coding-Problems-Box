// https://leetcode.com/problems/find-all-anagrams-in-a-string/

class Solution {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        let m: Int = s.count
        let n: Int = p.count
        guard m >= n else {
            return []
        }

        let A: Int = Int(Character("A").asciiValue!)
        var s_: [Character] = Array(s)
        var p_: [Character] = Array(p)

        // rabin-karp technique
        var rkSum: Int = s_.prefix(n).reduce(0, { $0 + Int($1.asciiValue!) - A + 1 })
        var rkArr: [Int] = [rkSum]
        for right in n..<m {
            rkSum -= Int(s_[right - n].asciiValue!)
            rkSum += Int(s_[right].asciiValue!)
            rkArr.append(rkSum)
        }

        // print("rkArr: \(rkArr)")

        let targetSum: Int = p_.reduce(0, { $0 + Int($1.asciiValue!) - A + 1 })
        var targetDict: [Character:Int] = [:]
        for char in p_ {
            targetDict[char] = targetDict[char, default: 0] + 1
        }
        var currDict: [Character:Int] = [:]
        for char in s_.prefix(n) {
            currDict[char] = currDict[char, default: 0] + 1
        }
        var result: [Int] = []

        // print("targetDict: \(targetDict)")
 
        // add dummy letter
        s_.append("$")
        for right in n...m {
            let left: Int = right - n
            if rkArr[left] == targetSum, currDict == targetDict {
                result.append(left)
            }
            currDict[s_[right]] = currDict[s_[right], default: 0] + 1
            currDict[s_[left]]! -= 1

            if currDict[s_[left]]! == 0 {
                currDict.removeValue(forKey: s_[left])
            }
        }

        return result
    }
}
