// https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/submissions/1827361760/

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

// represents traversing down to left/right child or stay at current node
enum Direction: String {
    case Left, Right, Same
}

class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var curr: TreeNode? = root
        var pDir: Direction = p!.val < curr!.val ? .Left : (p!.val > curr!.val ? .Right : .Same)
        var qDir: Direction = q!.val < curr!.val ? .Left : (q!.val > curr!.val ? .Right : .Same)

        // both p and q are on same side of current node
        while pDir == qDir
 {
            switch pDir {
                case .Left:
                    curr = curr!.left
                case .Right:
                    curr = curr!.right
                default:
                    print("NOT POSSIBLE")
            }

            // prep for next iteration
            pDir = p!.val < curr!.val ? .Left : (p!.val > curr!.val ? .Right : .Same)
            qDir = q!.val < curr!.val ? .Left : (q!.val > curr!.val ? .Right : .Same)
        }

        return curr
    }
}
