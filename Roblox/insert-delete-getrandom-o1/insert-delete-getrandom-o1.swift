// https://leetcode.com/problems/insert-delete-getrandom-o1/

class RandomizedSet {
    var rSet: Set<Int> = []

    init() {
        
    }
    
    func insert(_ val: Int) -> Bool {
        let result: Bool = !rSet.contains(val)
        rSet.insert(val)
        return result
    }
    
    func remove(_ val: Int) -> Bool {
        if rSet.contains(val) {
            rSet.remove(val)
            return true
        }

        return false
    }
    
    func getRandom() -> Int {
        rSet.randomElement()!
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */
 