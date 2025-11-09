// https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        let n: Int = prices.count
        var prefixMin: [Int] = prices
        for (i, x) in prices.enumerated().dropFirst() {
            // print("(\(i), \(x))")
            prefixMin[i] = min(prefixMin[i - 1], prices[i])
        }
        // print(prefixMin)

        var suffixMax: [Int] = prices
        for (i, x) in prices.enumerated().reversed().dropFirst() {
            // print("(\(i), \(x))")
            suffixMax[i] = max(suffixMax[i + 1], prices[i])
        }
        // print(suffixMax)

        if let result: Int = (0..<n).map { suffixMax[$0] - prefixMin[$0] }.max() {
            return result
        }

        return 0
    }
}