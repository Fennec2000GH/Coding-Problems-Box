// https://leetcode.com/problems/subtree-of-another-tree/

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
    // helper function to detect match at current roots
    func isSame(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
         if root == nil || subRoot == nil {
            return root == nil && subRoot == nil
        }

        if root!.val != subRoot!.val {
            return false
        }

        return isSame(root!.left, subRoot!.left) && isSame(root!.right, subRoot!.right)
        
    }

    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        // no need to traverse down further when one of roots is nil
        if root == nil || subRoot == nil {
            return root == nil && subRoot == nil
        }

        let subTreeHere: Bool = isSame(root, subRoot)
        guard subTreeHere else { 
            return isSubtree(root!.left, subRoot) || isSubtree(root!.right, subRoot)
        }

        return true
    }
}
