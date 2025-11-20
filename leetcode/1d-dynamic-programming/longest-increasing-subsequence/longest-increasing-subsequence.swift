// https://leetcode.com/problems/longest-increasing-subsequence/

class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        let n: Int = nums.count
        var lisLen: [Int] = Array(repeating: 0, count: n)
        lisLen[0] = 1
        for (i, x) in nums.enumerated().dropFirst() {
            lisLen[i] = ((0..<i).filter { nums[$0] < x }.map { lisLen[$0] }.max() ?? 0) + 1
        }
        return lisLen.max()!
    }
}
