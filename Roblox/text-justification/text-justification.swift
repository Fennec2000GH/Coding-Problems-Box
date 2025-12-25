// https://leetcode.com/problems/text-justification/

class Solution {
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var result: [String] = []
        var buffer: [String] = [words.first!]

        // size of all words plus single spacing between togther
        var size: Int = words.first!.count
        var spaceCnt: Int = -1
        var spacing: Int = -1
        var space: String = ""

        // fill up buffer for each line of final text
        for word in words.dropFirst() {
            // print("word: \(word)")
            if maxWidth - size >= word.count + 1 {
                buffer.append(word)
                size += word.count + 1
                continue
            }

            // print("filled buffer: \(buffer)")

            // edge case: one word fills entire buffer
            if buffer.count == 1 {
                spacing = maxWidth - size
                space = String(repeating: " ", count: spacing)
                result.append(buffer.first! + space)
            } else {
                // compute number of space characters and how to fill from left
                spaceCnt = (buffer.count - 1) + (maxWidth - size)
                spacing = spaceCnt / (buffer.count - 1)
                space = String(repeating: " ", count: spacing)
                // print("spaceCnt, spacing: \(spaceCnt), \(spacing)")

                let numExtraSpace: Int = spaceCnt % (buffer.count - 1)

                var line: [String] = [buffer.first!]
                for (i, word) in buffer.enumerated().dropFirst() {
                    line.append(space)
                    if i <= numExtraSpace {
                        line.append(" ")
                    }
                    line.append(word)
                }
                result.append(line.joined(separator: ""))
            }

            // prep for new buffer
            buffer = [word]
            size = word.count
        }

        // process last buffer as special case of left-justification
        if !buffer.isEmpty {
            let space: String = String(repeating: " ", count: maxWidth - size)
            result.append(buffer.joined(separator: " ") + space)
        }

        // print(result)
        return result
    }
}
