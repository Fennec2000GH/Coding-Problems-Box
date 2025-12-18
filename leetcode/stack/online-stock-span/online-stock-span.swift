// https://leetcode.com/problems/online-stock-span/

class StockSpanner {
    var stack: [(Int, Int)] = []

    init() {
        
    }
    
    func next(_ price: Int) -> Int {
        print(stack)
        var span: Int = 1
        while !stack.isEmpty {
            if let top: (Int, Int) = stack.last, top.0 <= price {
                span += top.1
                stack.removeLast()
                continue
            }
            break
        }
        stack.append((price, span))
        return span
    }
}

/**
 * Your StockSpanner object will be instantiated and called as such:
 * let obj = StockSpanner()
 * let ret_1: Int = obj.next(price)
 */
 