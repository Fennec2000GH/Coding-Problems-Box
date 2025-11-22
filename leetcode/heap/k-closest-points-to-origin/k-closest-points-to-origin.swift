// https://leetcode.com/problems/k-closest-points-to-origin/

import HeapModule

struct Point: Comparable {
    let x: Int
    let y: Int

    init (_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func distSq() -> Int {
        x*x + y*y
    }

    static func < (lhs: Point, rhs: Point) -> Bool {
        return lhs.distSq() < rhs.distSq()
    }

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.distSq() == rhs.distSq()
    }
}

class Solution {
    func kClosest(_ points: [[Int]], _ k: Int) -> [[Int]] {
        let n: Int = points.count
        var heap: Heap<Point> = []

        for point in points {
            let x: Int = point.first!
            let y: Int = point.last!
            heap.insert(Point(x, y))
        }

        var result: [[Int]] = []

        if k >= n / 2 {
            if k < n {
                for _ in 1...(n - k) {
                    heap.popMax()!
                }
            }
            result = Array(heap.unordered.map { [$0.x, $0.y] })
        } else {
            for _ in 1...k {
                let point: Point = heap.popMin()!
                result.append([point.x, point.y])
            }
        }

        return result
    }
}
