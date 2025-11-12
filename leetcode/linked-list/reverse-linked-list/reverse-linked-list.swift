// https://leetcode.com/problems/reverse-linked-list/

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    var started: Bool = false
    var tail: ListNode? = nil

    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let _: ListNode = head else {
            return nil
        }

        // first to flip "started" designates the starting node for original linked list

        var _started: Bool = false
        if !started {
            started = true
            _started = true
            tail = head
            while let next: ListNode = tail!.next {
                tail = next
            }
            // print("tail val: \(tail!.val)")
        }

        if head!.next == nil {
            // print("reached tail with val: \(head!.val)")
            return head
        }

        if let next: ListNode = head!.next, let remainder: ListNode = reverseList(next) {
            remainder.next = head
        }
        head!.next = nil

        // print(String(repeating: "-", count: 20))
        // print("val: \(head!.val)")
        // var node: ListNode = tail!
        // print(node.val)
        // while let next: ListNode = node.next {
        //     print(next.val)
        //     node = next
        // }

        return _started ? tail : head
    }
}
