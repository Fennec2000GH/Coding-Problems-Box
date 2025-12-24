// https://leetcode.com/problems/maximize-distance-to-closest-person/

class Solution {
    func maxDistToClosest(_ seats: [Int]) -> Int {
        let n: Int = seats.count
        var rightNbr: [Int:Int] = [:]

        // map each occupied seat to closest occupied seat to the right 
        var seats_: [(Int, Int)] = Array(seats.enumerated().reversed().drop {$0.1 == 0})
        let rightMost: Int = seats_.first!.0
        var curr: Int = rightMost
        seats_.dropFirst()

        for (i, x) in seats_ {
            if x == 1 {
                rightNbr[i] = curr
                curr = i
            }
        }

        // curr is now dist from seat 0 to first occupied seat
        return max(max(curr, n - rightMost - 1), rightNbr.map { $1 - $0 }.max()! / 2)
    }
}
