// https://leetcode.com/problems/evaluate-reverse-polish-notation/description/

enum Operator: String {
    case Add = "+", Subtract = "-", Multiply = "*", Divide = "/"
}

class Solution {
    func evalRPN(_ tokens: [String]) -> Int {
        var stack: [String] = []
        for token in tokens {
            stack.append(token)
            if let token: String = stack.last, let op: Operator = Operator(rawValue: token) {
                stack.removeLast() // remove confirmed operator token
                let b: Int = Int(stack.removeLast())!
                let a: Int = Int(stack.removeLast())!
                switch op {
                    case .Add:
                        stack.append(String(a + b))
                    case .Subtract:
                        stack.append(String(a - b))
                    case .Multiply:
                        stack.append(String(a * b))
                    case .Divide:
                        stack.append(String(a / b))                        
                }
            }
            // print(stack)
        }

        return Int(stack.removeLast())!
    }
}
