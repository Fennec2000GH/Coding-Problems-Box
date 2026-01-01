// https://leetcode.com/problems/word-search-ii/

import Algorithms

// no-deletion allowed trie
class Trie {
    var char: Character
    var wordIdx: Int // also acts as visited marker if != -1
    var children: [Character:Trie?] = [:]

    init(char: Character = "^", wordIdx: Int = -1) {
        self.char = char
        self.wordIdx = wordIdx
    }

    func insert(_ word: String, _ wordIdx: Int) {
        if let firstChar: Character = word.first {
            // print("insert: \(firstChar)")
            if !self.children.keys.contains(firstChar) {
                self.children[firstChar] = Trie(char: firstChar)
            }
            var child: Trie? = self.children[firstChar]!
            if word.count == 1 {
                // print("insert: new word")
                child!.wordIdx = wordIdx
                return
            }
            child!.insert(String(word.dropFirst()), wordIdx)
        }
    }

    func getWords() -> [String] {
        var chars: [Character] = []
        var words: [String] = []
        self.getWordsDfs(&chars, &words)
        return words
    }

    func getWordsDfs(_ chars: inout [Character], _ words: inout [String]) {
        chars.append(self.char)
        if self.wordIdx != -1 {
            words.append(String(chars))
        }
        for child in self.children.values {
            child!.getWordsDfs(&chars, &words)
        }
        chars.removeLast()
    }
    
    var description: String {
        let words: [String] = self.getWords()
        return "[" + words.joined(separator: ", ") + "]"
    }
}

class Solution {
    let a: Int = Int(Character("A").asciiValue!)

    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        var board_: [[Character]] = board
        let wordCnt: Int = words.count
        var root: Trie? = Trie()
        for i in 0..<wordCnt {
            root!.insert(words[i], i)
        }
        // print(root!.description)
      
        var result: Set<String> = []
        let m: Int = board_.count
        let n: Int = board_[0].count

        func dfs(_ node: inout Trie?, _ r: Int, _ c: Int) {
            let char: Character = board_[r][c]
            if let child: Trie? = node!.children[char] {
                // print("dfs: [\(r), \(c)], \(char)")
                let prevNode: Trie? = node
                node = child // this guaranteed to never be nil
                if node!.wordIdx != -1 {
                    let word: String = words[node!.wordIdx]
                    result.insert(word)
                    // print("dfs: \(word)")
                }

                let deltas: [[Int]] = [[0, 1], [-1, 0], [0, -1], [1, 0]]
                board_[r][c] = "#"
                for delta in deltas {
                    let newLoc: [Int] = [r + delta.first!, c + delta.last!]
                    if newLoc.first! >= 0, 
                        newLoc.first! < m, 
                        newLoc.last! >= 0, 
                        newLoc.last! < n, 
                        board_[newLoc.first!][newLoc.last!] != "#" {
                        dfs(&node, newLoc.first!, newLoc.last!)
                    }
                }

                node = prevNode
                board_[r][c] = char
            }
        }

        for r in 0..<m {
            for c in 0..<n {
                dfs(&root, r, c)
            }
        }

        return Array(result)
    }
}
