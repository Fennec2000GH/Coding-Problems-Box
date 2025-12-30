// https://leetcode.com/problems/random-pick-with-weight/

class Solution {
    var probSum: [Double] = []

    init(_ w: [Int]) {
        let sum: Double = Double(w.reduce(0, +))
        for wt in w {
            probSum.append((probSum.last ?? 0.0) + Double(wt) / sum)
        }
    }
    
    func binarySearch(_ x: Double) -> Int {
        var left: Int = 0
        var right: Int = probSum.count - 1
        var mid: Int = 0

        guard (probSum.last ?? 0.0) >= x else {
            return probSum.count
        }

        while right - left > 1 {
            mid = (left + right) / 2

            if x > probSum[mid] {
                left = mid
            } else {
                right = mid
            }
        }

        if probSum[left] >= x {
            return left
        }

        return right
    }

    func pickIndex() -> Int {
        let rand: Double = Double.random(in: 0.0...1.0)
        return binarySearch(rand)
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(w)
 * let ret_1: Int = obj.pickIndex()
 */
 