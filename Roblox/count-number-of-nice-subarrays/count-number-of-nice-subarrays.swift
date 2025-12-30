// https://leetcode.com/problems/count-number-of-nice-subarrays/

class Solution {
    func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n: Int = nums.count
        var idx: Int = -1
        
        // skiplists where, for each odd element, points to closest left or right neighbor that is also odd element
        var oddIdx: [Int] = []
        var leftOddIdx: [Int] = []
        for (i, x) in nums.enumerated() {
            if x % 2 == 1 {
                oddIdx.append(i)
                leftOddIdx.append(idx)
                idx = i
            }
        }

        let oddCnt: Int = oddIdx.count
        guard oddCnt >= k else {
            return 0
        }

        idx = n
        var rightOddIdx: [Int] = []
        for (i, x) in nums.enumerated().reversed() {
            if x % 2 == 1 {
                rightOddIdx.append(idx)
                idx = i
            }
        }
        rightOddIdx.reverse()

        print(oddIdx)
        print(leftOddIdx)
        print(rightOddIdx)

        var result: Int = 0
        for right in (k - 1)..<oddCnt {
            let left: Int = right - k + 1

            // count contiguous non-odd elements to the left of window
            let leftCnt: Int = oddIdx[left] - leftOddIdx[left] - 1

            // do the same counting to the right of window
            let rightCnt: Int = rightOddIdx[right] - oddIdx[right] - 1
            result += (leftCnt + 1) * (rightCnt + 1)
        }

        return result
    }
}
