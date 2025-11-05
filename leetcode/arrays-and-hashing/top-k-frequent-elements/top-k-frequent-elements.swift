
// https://leetcode.com/problems/top-k-frequent-elements/
// Note: TreeDictionary.max has unknown time complexity
import HashTreeCollections

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var counter: [Int:Int] = [:]
        for x in nums {
            counter[x] = counter[x, default: 0] + 1
        }

        if counter.count <= k {
            return Array(counter.keys)
        }

        var tree = TreeDictionary(grouping: counter.keys, by: { counter[$0]! })
        print("tree:\n\(tree)")
        for node in tree {
            print(node)
        }

        var result: [Int] = []
        while result.count < k && !tree.isEmpty {
            let maxNode = tree.max { kv1, kv2 in kv1.key < kv2.key }!
            print(maxNode)
            tree.removeValue(forKey: maxNode.key)
            result += maxNode.value
            print(result)
        }

        result = Array(result[0..<k])
        print(result)
        return result
    }
}


// WIP max-heap solution
// class Solution {
//     func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {

//         var counter: [Int:Int] = [:]
//         for x in nums {
//             counter[x] = counter[x, default: 0] + 1
//         }
//         var keys: [Int] = Array(counter.keys)
//         let n: Int = keys.count

//         print("keys:\n\(keys)")

//         // heapify in-place (for value parameter)
//         print(String(repeating: "=", count: 20))
//         for i in (0..<n).reversed() {
//             print(String(repeating: "-", count: 20))
//             var curri: Int = i
//             while true {
//                 var maxi: Int = curri
//                 let li: Int = 2*curri + 1
//                 let ri: Int = 2*curri + 2
//                 print("curri, li, ri: \(curri), \(li), \(ri)")
//                 print("triplet: (\(keys[curri]), \(counter[keys[curri]])), (\(li < n ? String(keys[li]) + ", " + String(counter[keys[li]]!): nil)), \(ri < n ? String(keys[ri]) + ", " + String(counter[keys[ri]]!) : nil)")
                
//                 if li < n && counter[keys[li]]! > counter[keys[maxi]]! {
//                     maxi = li
//                 }
//                 if ri < n && counter[keys[ri]]! > counter[keys[maxi]]! {
//                     maxi = ri
//                 }

//                 print("maxi: \(maxi)")

//                 // current element is already max in triplet
//                 if maxi == curri {
//                     break
//                 }

//                 keys.swapAt(curri, maxi)
//                 curri = maxi
//             }
//         }

//         print("heapified keys:\n\(keys)")

//         // pop k times
//         print(String(repeating: "=", count: 20))
//         var result: [Int] = []
//         for t in 1...k {
//             print(String(repeating: "-", count: 20))
//             print("t: \(t)")
//             result.append(keys.first!)
//             keys.swapAt(0, n - t)

//             var curri: Int = t - 1
//             while true {
//                 var maxi: Int = curri
//                 let li: Int = 2*curri + 1
//                 let ri: Int = 2*curri + 2
//                 let _n: Int = n - t
//                 if li < _n && counter[keys[li]]! > counter[keys[maxi]]! {
//                     maxi = li
//                 }
//                 if ri < _n && counter[keys[ri]]! > counter[keys[maxi]]! {
//                     maxi = ri
//                 }

//                 print("maxi: \(maxi)")

//                 if maxi == curri {
//                     break
//                 }
//                 keys.swapAt(curri, maxi)
//                 curri = maxi
//             }

//             print(keys)
//             print(result)
//         }


//         return result
//     }
// }