// https://leetcode.com/problems/longest-consecutive-sequence/

class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        var seen: Set<Int> = Set([])
        var span: [Int:Int] = [:]

        for x in nums {
            // print(String(repeating: "-", count: 20))
            // print(x)
            // print(seen)
            // print(span)

            if seen.contains(x) {
                continue
            }
            var leftStart: Int = 0
            if let _leftStart: Int = span[x - 1] {
                leftStart = _leftStart
                span.removeValue(forKey: x - 1)
                span[_leftStart] = x
                span[x] = _leftStart
            } else {
                leftStart = x
                span[x] = x
            }

            if let _rightStart: Int = span[x + 1] {
                span.removeValue(forKey: x + 1)
                span.removeValue(forKey: x)
                span[leftStart] = _rightStart
                span[_rightStart] = leftStart
            }

            seen.insert(x)
        }

        return span.map{ abs($0.key - $0.value) }.max().map{ $0 + 1} ?? 0
    }
}
