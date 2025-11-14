// https://leetcode.com/problems/kth-smallest-element-in-a-bst/

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
    var cnt: Int = 0
    var result: Int = -1
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        guard let _ : TreeNode = root else {
            return -1
        }

        kthSmallest(root!.left, k)
        cnt += 1
        if cnt == k {
            result = root!.val
            return result
        }
        kthSmallest(root!.right, k)

        // should not actually be reached given constraints on k
        return result
    }
}
