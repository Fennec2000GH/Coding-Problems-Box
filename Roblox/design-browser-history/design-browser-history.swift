// https://leetcode.com/problems/design-browser-history/

import DequeModule

class BrowserHistory {
    var d1: Deque<String> = []
    var d2: Deque<String> = []

    init(_ homepage: String) {
        d1.append(homepage)
    }
    
    func visit(_ url: String) {
        d2.removeAll()
        d1.append(url)
    }
    
    func back(_ steps: Int) -> String {
        let steps_: Int = min(steps, d1.count - 1)
        if steps_ == 0 {
            return d1.last!
        }

        for _ in 1...steps_ {
            d2.prepend(d1.popLast()!)
        }
        return d1.last!
    }
    
    func forward(_ steps: Int) -> String {
        let steps_: Int = min(steps, d2.count)
        if steps_ == 0 {
            return d1.last!
        }

        for _ in 1...steps_ {
            d1.append(d2.popFirst()!)
        }
        return d1.last!
    }
}

/**
 * Your BrowserHistory object will be instantiated and called as such:
 * let obj = BrowserHistory(homepage)
 * obj.visit(url)
 * let ret_2: String = obj.back(steps)
 * let ret_3: String = obj.forward(steps)
 */
 