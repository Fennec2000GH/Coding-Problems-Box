// https://leetcode.com/problems/serialize-and-deserialize-binary-tree/

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

class Codec {
    func serialize(_ root: TreeNode?) -> String {
        var result = [String]()
        func dfs(_ node: TreeNode?) {
            if let node = node {
                result.append(String(node.val))
                dfs(node.left)
                dfs(node.right)
            } else {
                result.append("nil") // Placeholder for null nodes
            }
        }
        dfs(root)
        return result.joined(separator: ",")
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        var nodes = data.split(separator: ",").map { String($0) }
        var index = 0

        func buildTree() -> TreeNode? {
            guard index < nodes.count else { return nil }

            let val = nodes[index]
            index += 1

            if val == "nil" {
                return nil
            }

            let node = TreeNode(Int(val)!)
            node.left = buildTree()
            node.right = buildTree()
            return node
        }
        return buildTree()
    }
}

// Your Codec object will be instantiated and called as such:
// var ser = Codec()
// var deser = Codec()
// deser.deserialize(ser.serialize(root))
