// https://leetcode.com/problems/diameter-of-binary-tree/

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
    var result: Int = 0
    var started: Bool = false

    // returns maxDepth unless caller is original root
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let _: TreeNode = root else {
            return 0
        }

        var _started: Bool = false
        if !started {
            started = true
            _started = true
        }

        
        let leftDepth: Int = diameterOfBinaryTree(root!.left)
        let rightDepth: Int = diameterOfBinaryTree(root!.right)
        result = max(result, leftDepth + rightDepth)
        
        if _started {
            return result
        }
        
        return 1 + max(leftDepth, rightDepth)
    }
}
