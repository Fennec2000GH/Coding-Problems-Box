// https://leetcode.com/problems/count-good-nodes-in-binary-tree/

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
    var lowerBound: Int = -10000
    func goodNodes(_ root: TreeNode?) -> Int {
        guard let _: TreeNode = root else {
            return 0
        }


        // current node is not good
        var good: Bool = true
        if root!.val < lowerBound {
            good = false
            root!.val = lowerBound
        }
        
        lowerBound = root!.val            
        let leftCnt: Int = goodNodes(root!.left)
        lowerBound = root!.val
        let rightCnt: Int = goodNodes(root!.right)
        
        return (good ? 1 : 0) + leftCnt + rightCnt
    }
}
