// https://leetcode.com/problems/balanced-binary-tree/

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
    var started: Bool = false

    // convert tree to store max depth per node as val
    func maxDepthConvert(_ root: TreeNode?) -> Int {
        guard let _: TreeNode = root else {
            return 0
        }

        let depth: Int = 1 + max(maxDepthConvert(root!.left), maxDepthConvert(root!.right))
        root!.val = depth
        return depth
    }

    func isBalanced(_ root: TreeNode?) -> Bool {
        if !started {
            started = true
            maxDepthConvert(root)
        }

        guard let _: TreeNode = root else {
            return true
        }
        
        let leftDepth: Int = root!.left?.val ?? 0
        let rightDepth: Int = root!.right?.val ?? 0

        if Int(abs(leftDepth - rightDepth)) > 1 {
            return false
        }

        return isBalanced(root!.left) && isBalanced(root!.right)
    }
}
