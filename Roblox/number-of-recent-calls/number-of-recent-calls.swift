// https://leetcode.com/problems/number-of-recent-calls/
import DequeModule

class RecentCounter {
    var q: Deque<Int> = []

    init() {
        
    }
    
    func ping(_ t: Int) -> Int {
        let bound: Int = t - 3000
        q.append(t)
        while q.first! < bound {
            q.popFirst()
        }

        return q.count
    }
}

/**
 * Your RecentCounter object will be instantiated and called as such:
 * let obj = RecentCounter()
 * let ret_1: Int = obj.ping(t)
 */
 