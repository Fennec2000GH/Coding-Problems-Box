// https://leetcode.com/problems/validate-binary-search-tree/

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    // strict lower and upper bounds at each node visit
    var leftStack: [Int] = []
    var rightStack: [Int] = []

    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let _ : TreeNode = root else {
            return true
        }

        // check for bound violations
        if let lowerBound: Int = leftStack.last, root!.val <= lowerBound {
            return false
        }
        if let upperBound: Int = rightStack.last, root!.val >= upperBound {
            return false
        }

        rightStack.append(root!.val)
        guard isValidBST(root!.left) else {
            return false
        }
        rightStack.removeLast()
        leftStack.append(root!.val)
        guard isValidBST(root!.right) else {
            return false
        }
        leftStack.removeLast()
        return true
    }
}
