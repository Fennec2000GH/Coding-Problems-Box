// https://leetcode.com/problems/sort-list/

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
    func mergeSort(_ head: ListNode?, _ n: Int) -> ListNode? {
        // print("----------")
        if n == 1 {
            return head
        } else if n == 2 {
            if head!.val > head!.next!.val {
                var nbr: ListNode? = head!.next
                nbr!.next = head
                head!.next = nil
                return nbr
            }
            return head
        }
        
        var mid: ListNode? = head
        for _ in 1...(n - 1)/2 {
            mid = mid!.next
        }
        var head2: ListNode? = mid!.next
        mid!.next = nil
        // print("mid: \(mid), heads: \(head!.val), \(head2!.val), sizes: \((n + 1) / 2), \(n / 2)")

        // merging
        var ptr1: ListNode? = mergeSort(head, (n + 1) / 2)
        var ptr2: ListNode? = mergeSort(head2, n / 2)
        var result: ListNode? = ListNode() // dummy
        var end: ListNode? = result
        // print("merging...")

        while let ptr1_: ListNode = ptr1, let ptr2_: ListNode = ptr2 {
            if ptr1_.val <= ptr2_.val {
                end!.next = ptr1
                end = end!.next
                ptr1 = ptr1!.next
            } else {
                end!.next = ptr2
                end = end!.next
                ptr2 = ptr2!.next
            }
        }

        // attach remaining tail of longer un-merged list
        if let ptr1_: ListNode = ptr1 {
            end!.next = ptr1
        } else if let ptr2_: ListNode = ptr2 {
            end!.next = ptr2
        }

        // rid of dummy node
        result = result!.next

        // // debugging only
        // end = result
        // while let ptr_: ListNode = end {
        //     print(ptr_.val)
        //     end = end!.next
        // }

        return result
    }

    func sortList(_ head: ListNode?) -> ListNode? {
        // print("----------")
        guard let head_: ListNode = head else {
            return nil
        }

        var n: Int = 0
        var ptr: ListNode? = head
        while let ptr_: ListNode = ptr {
            n += 1
            ptr = ptr_.next
        }

        // print("original n: \(n)")
        return mergeSort(head, n)
    }
}
