// https://leetcode.com/problems/permutation-in-string/

class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let n1: Int = s1.count
        let n2: Int = s2.count
        guard n1 <= n2 else {
            return false
        }
        guard s1.sorted() != String(s2.prefix(n1)).sorted() else {
            return true
        }

        var counter1: [Character:Int] = [:]
        for x in s1 {
            counter1[x] = counter1[x, default: 0] + 1
        }
        // print(counter1)

        var counter2: [Character:Int] = [:]
        for x in s2.prefix(n1) {
            counter2[x] = counter2[x, default: 0] + 1
        }
        // print(counter2)

        var left: Int = 0
        var s2_arr: [Character] = Array(s2)
        for (right, x) in s2.enumerated().dropFirst(n1) {
            // print(String(repeating: "-", count: 20))

            counter2[x] = counter2[x, default: 0] + 1
            let leftChar: Character = s2_arr[left]
            if let leftCnt: Int = counter2[leftChar] {
                if leftCnt == 1 {
                    counter2.removeValue(forKey: leftChar)
                } else {
                    counter2[leftChar] = leftCnt - 1
                }
            } else { 
                // print("This should never happen.")
                return false
            }

            left += 1

            // print("left, right: \(left), \(right)")
            print(counter2)
            if counter1 == counter2 {
                return true
            }
        }

        return false
    }
}
