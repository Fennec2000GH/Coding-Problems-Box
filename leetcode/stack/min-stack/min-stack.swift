// https://leetcode.com/problems/min-stack/

class MinStack {
    var stack: [Int] = []
    var prefixMin: [Int] = []

    init() {
        
    }
    
    func push(_ val: Int) {
        stack.append(val)
        if let minSoFar: Int = prefixMin.last {
            prefixMin.append(min(minSoFar, val))
        } else {
            prefixMin.append(val)
        }
    }
    
    func pop() {
        stack.removeLast()
        prefixMin.removeLast()
    }

    func top() -> Int {
        return stack.last!
    }
    
    func getMin() -> Int {
        return prefixMin.last!
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(val)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */
