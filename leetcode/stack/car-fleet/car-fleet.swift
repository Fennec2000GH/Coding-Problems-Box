// https://leetcode.com/problems/car-fleet/

class Solution {
    func carFleet(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
        let n: Int = speed.count
        let sortedPairs: [(Int, Int)] = zip(position, speed).sorted(by: > )
        // print(sortedPairs)

        var timeNeeded: [Double] = Array(repeating: 0.0, count: n) 
        for (i, (pos, speed)) in sortedPairs.enumerated() {
            timeNeeded[i] = Double(target - pos) / Double(speed)
        }
        // print(timeNeeded)

        var stack: [Double] = []
        for t in timeNeeded {
            if let top: Double = stack.last, t <= top {
                // do nothing (adds to current pile-up)
                continue
            }

            // start new pile-up
            print("pile-up starting with time needed: \(t)")
            stack.append(t)
        }

        return stack.count
    }
}
