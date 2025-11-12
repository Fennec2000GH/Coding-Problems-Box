// https://leetcode.com/problems/merge-two-sorted-lists/

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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard let _ = list1 else {
            return list2
        }
        guard let _ = list2 else {
            return list1
        }

        var ptr1: ListNode? = list1
        var ptr2: ListNode? = list2

        // start with dummy node
        var result: ListNode? = ListNode()
        var curr: ListNode? = result

        while let _: ListNode = ptr1, let _: ListNode = ptr2 {
            if ptr1!.val <= ptr2!.val {
                curr!.next = ptr1
                ptr1 = ptr1!.next
            } else {
                curr!.next = ptr2
                ptr2 = ptr2!.next
            }
            curr = curr!.next
        }
        
        // only 1 list has remaining nodes
        if let _: ListNode = ptr1 {
            curr!.next = ptr1
        } else {
            curr!.next = ptr2
        }

        // clean up dummy node
        var dummy: ListNode? = result
        result = result!.next
        dummy!.next = nil

        return result
    }
}
