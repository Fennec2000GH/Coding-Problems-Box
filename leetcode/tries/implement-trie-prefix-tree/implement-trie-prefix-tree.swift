
class Node {
    var val: Character = Character("*")
    var terminal: Bool = false
    var children: [Character:Node] = [:]

    init(_ val: Character = Character("*")) {
        self.val = val
    }

    func addChild(_ val: Character) {
        children[val] = Node(val)
    }

    func getChild(_ val: Character) -> Node? {
        return children[val]
    }

    func hasChild(_ val: Character) -> Bool {
        if let _: Node = children[val] {
            return true
        }
        return false
    }

    func getTerminal() -> Bool {
        terminal
    }
    
    func setTerminal() {
        terminal = true
    }
}

class Trie {
    var root: Node = Node()

    init() {}
    
    func insert(_ word: String) {
        var curr: Node = root
        for char in word {
            if curr.getChild(char) == nil {
                curr.addChild(char)
            }
            curr = curr.getChild(char)!
        }
        curr.setTerminal()
    }
    
    func search(_ word: String) -> Bool {
        var curr: Node = root
        for char in word {
            if let child: Node = curr.getChild(char) {
                curr = child
                continue
            }
            return false
        }
        return curr.getTerminal()
    }
    
    func startsWith(_ prefix: String) -> Bool {
        var curr: Node = root
        for char in prefix {
            if let child: Node = curr.getChild(char) {
                curr = child
                continue
            }
            return false
        }
        return true
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * let obj = Trie()
 * obj.insert(word)
 * let ret_2: Bool = obj.search(word)
 * let ret_3: Bool = obj.startsWith(prefix)
 */
 