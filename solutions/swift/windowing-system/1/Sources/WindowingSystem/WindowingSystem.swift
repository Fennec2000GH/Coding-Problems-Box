// TODO: Define the Size struct
struct Size {
    var width: Int = 80
    var height: Int = 60

    mutating func resize(newWidth: Int, newHeight: Int) {
        width = newWidth
        height = newHeight
    }
}


// TODO: Define the Position struct
struct Position {
    var x: Int = 0
    var y: Int = 0
    
    mutating func moveTo(newX: Int, newY: Int) {
        self.x = newX
        self.y = newY
    }
    
}


// TODO: Define the Window class
class Window {
    var title: String
    var size: Size
    var position: Position
    var contents: String?        
    let screenSize: Size
    
    
    init (title: String = "New Window",
          contents: String? = nil,
          size: Size = Size(width: 80, height: 60), 
          position: Position = Position(x: 0, y: 0),
          screenSize: Size = Size(width: 800, height: 600)) {
        self.title = title
        self.screenSize = screenSize
        self.size = size
        self.position = position
        self.contents = contents
        
        self.resize(to: self.size)
        self.move(to: self.position)
    }
    
    func resize(to newSize: Size) {

        let clampedWidth = max(1, min(newSize.width, screenSize.width - position.x))
        
        let clampedHeight = max(1, min(newSize.height, screenSize.height - position.y))
        
        self.size = Size(width: clampedWidth, height: clampedHeight)
        
    }
    
    func move(to newPosition: Position){
        let clampedX = max(0, min(newPosition.x, screenSize.width - self.size.width))
        
        let clampedY = max(0, min(newPosition.y, screenSize.height - self.size.height))
        
        self.position = Position(x: clampedX, y: clampedY)

    }
    
    func update(title: String) {
        self.title = title
    }
    
    func update(text: String?) {
        self.contents = text ?? "[This window intentionally left blank]"
    }
    
    func display() -> String {
        
        let displayText = contents ?? "[This window intentionally left blank]"

        return "\(title)\nPosition: (\(position.x), \(position.y)), Size: (\(size.width) x \(size.height))\n\(displayText)\n"
    }
}