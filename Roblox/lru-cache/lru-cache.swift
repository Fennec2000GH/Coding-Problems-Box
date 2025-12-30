// https://leetcode.com/problems/lru-cache/
// Prones to crashing. This is a proof-oc-concept to avoid using doubly linked list for LRU cache.

class LRUCache {
    // NOTE: the "buffer" actually exists as element indexed at 3 in nbrIdx

    // when to re-construct buffer to remove tombstoned elements
    // let factor: Int = 2
    var capacity: Int = 0

    // skip lists, where for each living index, which is next closest living index to the left or right
    // value is [left neighbor, right neighbor, value in buffer at index == nbrIdx's key]
    var nbrIdx: [Int:[Int]] = [:]

    // maps key to most recent index where it currently lives in buffer
    var mrIdx: [Int:Int] = [:]
    
    // smallest and largest indices in buffer holding a living element
    var minIdx: Int = 0
    var maxIdx: Int = -1

    // maps key to value
    var cache: [Int:Int] = [:]

    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    // returns true/false indicating whether any action was taken (key must already exist)
    func use(_ key: Int) -> Bool {
        // only handles when key currently exists in cache and not already most recently used
        if let idx: Int = mrIdx[key], idx < maxIdx {
            // remove old mappings
            var leftNbr: Int = nbrIdx[idx]![0]
            var rightNbr: Int = nbrIdx[idx]![1]
            let kvp: [Int] = Array(nbrIdx[idx]![2...])
            // print("use (before): \(idx), \(leftNbr), \(rightNbr), \(minIdx), \(maxIdx)")

            if idx == minIdx {
                minIdx = rightNbr
                nbrIdx[rightNbr]![0] = -1
            } else {
                nbrIdx[leftNbr]![1] = rightNbr
                nbrIdx[rightNbr]![0] = leftNbr
            }
            nbrIdx.removeValue(forKey: idx)

            // update mappings
            maxIdx += 1
            mrIdx[key] = maxIdx

            leftNbr = maxIdx - 1
            if leftNbr != -1 {
                nbrIdx[leftNbr]![1] = maxIdx
            }
            nbrIdx[maxIdx] = [maxIdx - 1, -1] + kvp
            // print("use (after): \(idx), \(leftNbr), \(rightNbr), \(minIdx), \(maxIdx)")

            return true
        }

        return false
    }

    func get(_ key: Int) -> Int {
        // print("----------")
        // print("get: \(key)")
        use(key)

        // print("dictionaries:")
        // print(nbrIdx)
        // print(mrIdx)
        // print(cache)

        return cache[key, default: -1]
    }
    
    func put(_ key: Int, _ value: Int) {
        // print("----------")
        // print("put: \(key), \(value)")
        // only handle when key is new as of now
        if !use(key) {
            // evict LRU key if necessary
            if cache.count == capacity {
                let rightNbr: Int = nbrIdx[minIdx]![1]
                let kvp: [Int] = Array(nbrIdx[minIdx]![2...])
                nbrIdx.removeValue(forKey: minIdx)
                minIdx = rightNbr
                nbrIdx[rightNbr]![0] = -1
                mrIdx.removeValue(forKey: kvp.first!)
                cache.removeValue(forKey: kvp.first!)
            }

            maxIdx += 1
            mrIdx[key] = maxIdx

            let leftNbr: Int = maxIdx - 1
            if leftNbr != -1 {
                nbrIdx[leftNbr]![1] = maxIdx
            }
            nbrIdx[maxIdx] = [maxIdx - 1, -1, key, value]
        }
        cache[key] = value

        // print("dictionaries:")
        // print(nbrIdx)
        // print(mrIdx)
        // print(cache)
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
