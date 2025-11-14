// https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/

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
    var inorderLookup: [Int:Int] = [:]
    var _preorder: [Int] = []
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        // make some copies for helper function access
        _preorder = preorder

        for (i, x) in inorder.enumerated() {
            inorderLookup[x] = i
        }

        let n: Int = preorder.count
        return helper(0, 0, n)
    }

    // parameters refer to indexes of left end of subrange on preorder/inorder arrays
    func helper(_ preorderLeft: Int, _ inorderLeft: Int, _ length: Int) -> TreeNode? {
        guard length > 0 else {
            return nil
        }

        var root: TreeNode = TreeNode(_preorder[preorderLeft])
        // print(String(repeating: "-", count: 20))
        // print("val: \(root.val)")
        // print("params: \(preorderLeft),\(inorderLeft),\(length)")

        let newPreorderLeft: Int = preorderLeft + 1
        let mid: Int = inorderLookup[_preorder[preorderLeft]]!
        let newInorderLeft: Int = mid + 1
        let leftLength: Int = mid - inorderLeft

        // print("mid, leftLength: \(mid),\(leftLength)")

        root.left = helper(newPreorderLeft, inorderLeft, leftLength)
        root.right = helper(preorderLeft + leftLength + 1, newInorderLeft, length - leftLength - 1)
        
        return root
    }
}

