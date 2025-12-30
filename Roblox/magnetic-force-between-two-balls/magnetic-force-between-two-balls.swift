// https://leetcode.com/problems/magnetic-force-between-two-balls/

class Solution {
    func maxDistance(_ position: [Int], _ m: Int) -> Int {
        let n: Int = position.count
        let pos: [Int] = position.sorted()

        func checkPlacement(_ gap: Int) -> Bool {
            var bCnt: Int = 1
            var previouspos: Int = pos.first!

            for i in 1..<n {
                if pos[i] - previouspos >= gap {
                    bCnt += 1
                    previouspos = pos[i]
                    if bCnt == m {
                        return true
                    }
                }
            }

            return false
        }
        
        // binary search
        var left: Int = 1
        var right: Int = pos.last! - pos.first!
        var idx: Int = -1

        while (left <= right) {
            var mid: Int = left + (right - left) / 2

            if !checkPlacement(mid) {
                idx = mid
                right = mid - 1
            } else {
                left = mid + 1
            }
        }

        if idx == -1 {
            return pos.last! - pos.first!
        }

        return idx - 1
    }
}
