// https://leetcode.com/problems/largest-rectangle-in-histogram/

class Solution {
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let n: Int = heights.count
        var tallerOnLeft: [Int] = Array(repeating: 0, count: n)
        var tallerOnRight: [Int] = Array(repeating: 0, count: n)
        var stack: [(Int, Int)] = [] // (index, taller bar count on 1 side)
        
        // track number of bars taller on left of each bar
        for (i, x) in heights.enumerated() {
            let h: Int = heights[i]
            var cnt: Int = 0
            while let (left_i, left_cnt): (Int, Int) = stack.last, h <= heights[left_i] {
                cnt += left_cnt + 1
                tallerOnLeft[left_i] = left_cnt
                stack.removeLast()
            }
            stack.append((i, cnt))
            // print(stack)
        }
        for (i, cnt) in stack {
            tallerOnLeft[i] = cnt
        }
        stack.removeAll()
        // print(tallerOnLeft)

        // track number of bars taller on right of each bar
        for (i, x) in heights.enumerated().reversed() {
            let h: Int = heights[i]
            var cnt: Int = 0
            while let (right_i, right_cnt): (Int, Int) = stack.last, h <= heights[right_i] {
                // save info for removed bars
                cnt += right_cnt + 1
                tallerOnRight[right_i] = right_cnt
                stack.removeLast()
            }
            stack.append((i, cnt))
            // print(stack)
        }
        for (i, cnt) in stack {
            tallerOnRight[i] = cnt
        }
        // print(tallerOnRight)
    
        return (0..<n).map { (tallerOnLeft[$0] + tallerOnRight[$0] + 1) * heights[$0]}.max() ?? -1
    }
}
