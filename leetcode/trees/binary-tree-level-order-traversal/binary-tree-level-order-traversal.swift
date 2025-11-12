// https://leetcode.com/problems/binary-tree-level-order-traversal/

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
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let _: TreeNode = root else {
            return []
        }

        var level: [TreeNode] = []
        var result: [[TreeNode]] = [[root!]]

        repeat {
            level.removeAll()
            if let prevLevel: [TreeNode] = result.last {
                for node in prevLevel {
                    if let left: TreeNode = node.left {
                        level.append(left)
                    }
                    if let right: TreeNode = node.right {
                        level.append(right)
                    }
                }
                if !level.isEmpty {
                    result.append(level)
                }
            }
        } while !level.isEmpty

        var finalResult: [[Int]] = []
        for level in result {
            finalResult.append( Array(level.map { $0.val }) )
        }

        return finalResult
    }
}
