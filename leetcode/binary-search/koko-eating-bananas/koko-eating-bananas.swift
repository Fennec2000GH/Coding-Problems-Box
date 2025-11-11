// https://leetcode.com/problems/koko-eating-bananas/

class Solution {
    func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        let n: Int = piles.count

        guard n <= h else {
            // cannot have less hours than piles of bananas
            return -1
        }

        // initial estimate for bound, which could be upper or lower
        let piles_sum: Int = piles.reduce(0, +)
        let k_cand: Int = Int(ceil(Double(piles_sum) / Double(h)))
        let k_cand_h: Int = piles.map { Int(ceil(Double($0) / Double(k_cand))) }.reduce(0, +)
        // print("piles_sum, k_cand, k_cand_h: \(piles_sum), \(k_cand), \(k_cand_h)")

        // bounds for binary search
        var upper: Int = piles_sum
        var lower: Int = k_cand
        var mid: Int = (upper + lower) / 2
        var h_required: Int = -1

        while lower < upper {
            mid = lower + (upper - lower) / 2
            h_required = piles.map { Int(ceil(Double($0) / Double(mid))) }.reduce(0, +)
            // print("lower, upper, mid, h_required: \(lower), \(upper), \(mid), \(h_required)")

            // eating rate is too low when required hours does not exceed h
            if h_required > h {
                if lower == mid {
                    mid = upper
                }
                lower = mid
            } else {
                upper = mid
            }
        }

        return mid
    }
}
