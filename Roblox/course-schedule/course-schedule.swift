// https://leetcode.com/problems/course-schedule/

import Algorithms
import DequeModule

class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var inDeg: [Int:Int] = Dictionary(uniqueKeysWithValues: zip(0..<numCourses, [0].cycled()))
        var mapper: [Int:[Int]] = Dictionary(uniqueKeysWithValues: zip(0..<numCourses, [[]].cycled()))

        for pre in prerequisites {
            guard pre.first! != pre.last! else {
                return false
            }

            inDeg[pre.last!]! += 1
            mapper[pre.first!]!.append(pre.last!)
        }

        var q: Deque<Int> = []
        for next in (0..<numCourses).filter { inDeg[$0] == 0 } {
            q.append(next)
            inDeg.removeValue(forKey: next)
        }

        while !q.isEmpty {
            let course: Int = q.popFirst()!
            for next in mapper[course, default: []] {
                inDeg[next]! -= 1
                if inDeg[next]! == 0 {
                    inDeg.removeValue(forKey: next)
                    q.append(next)
                }
            }
        }

        return inDeg.isEmpty
    }
}
