// https://leetcode.com/problems/longest-repeating-character-replacement/

class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        let n: Int = s.count
        var left: Int = 0
        var counter: [Character:Int] = [:]
        let s_arr: [Character] = Array(s)

        for (right, x) in s_arr.enumerated() {
            counter[x] = counter[x, default: 0] + 1
            var mostFreq: Int = counter.values.max()!
            let winLen: Int = right - left + 1
            if winLen - mostFreq > k {
                counter[s_arr[left]]! -= 1
                left += 1
            }
        }

        return n - left
    }
}
