// https://leetcode.com/problems/remove-colored-pieces-if-both-neighbors-are-the-same-color/

class Solution {
    func winnerOfGame(_ colors: String) -> Bool {
        var colors_: [Character] = Array(colors)
        colors_.append("D") // dummy last color

        var aliceCnt: Int = 0
        var bobCnt: Int = 0

        let n: Int = colors_.count
        var cnt: Int = 1
        for i in 1..<n {
            if colors_[i] == colors_[i - 1] {
                cnt += 1
            } else {
                guard cnt >= 3 else {
                    cnt = 1
                    continue
                }

                let numMoves: Int =  cnt - 2
                if colors_[i - 1] == "A" {
                    aliceCnt += numMoves
                } else {
                    bobCnt += numMoves
                }
                cnt = 1
            }
        }

        return aliceCnt > bobCnt
    }
}
