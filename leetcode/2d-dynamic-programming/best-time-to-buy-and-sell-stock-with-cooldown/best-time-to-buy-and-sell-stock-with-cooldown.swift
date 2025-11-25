// https://leetcode.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        let n: Int = prices.count
        guard n >= 2 else {
            return 0;
        }

        var s_nohold: Int = 0 
        var s_hold: Int = -prices.first! 
        var s_cooldown: Int = 0;
        for i in 1..<n {
            let prev: Int = s_cooldown
            s_cooldown = s_hold + prices[i]
            s_hold = max(s_hold, s_nohold - prices[i])
            s_nohold = max(s_nohold, prev)
        }
        return max(s_nohold, s_cooldown)
    }
}
