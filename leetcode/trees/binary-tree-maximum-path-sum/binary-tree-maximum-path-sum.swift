// https://leetcode.com/problems/binary-tree-maximum-path-sum/

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
    // if every node is negative, worst case is choosing 1 node with value -1000
    var result: Int = -1000
    var started: Bool = false
    func maxPathSum(_ root: TreeNode?) -> Int {
        guard let _: TreeNode = root else {
            return 0
        }

        // flag the call started by root
        var _started: Bool = false
        if !started {
            started = true
            _started = true
        }
        
        // max sum of path that ends exactly at left child or right child
        let leftSum: Int = maxPathSum(root!.left)
        let rightSum: Int = maxPathSum(root!.right)
        result = max(result, root!.val + max(0, leftSum) + max(0, rightSum))

        // reset current node value to max sum of path that ends exactly at this node
        root!.val = max(root!.val, root!.val + max(leftSum, rightSum))

        if _started {
            return result
        }

        return root!.val
    }
}
