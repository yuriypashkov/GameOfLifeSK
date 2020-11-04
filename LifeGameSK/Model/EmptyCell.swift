import SpriteKit

class EmptyCell: SKShapeNode {
    
    var isAlive: Bool = false
    var positionInArray: Int?
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, position: Int) {
        super.init()
        self.path = CGPath(rect: CGRect(x: x, y: y, width: width, height: width), transform: .none)
        self.fillColor = .systemGreen
        self.isUserInteractionEnabled = true
        self.name = "EmptyCell"
        positionInArray = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithState(_ isAlive: Bool) {
        self.fillColor = isAlive ? UIColor.systemRed : UIColor.systemGreen
    }
    
}

extension EmptyCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //мало покрасить клетку - надо еще в игровой модели сделать эту клетку Живой
        game.currentState[self.positionInArray!] = Cell.makeLiveCell() // это работает но это ужасно. Первое что приходит на ум - переделать с использованием протокола
        self.configureWithState(true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            print("Touch location is \(location) AND cell position is \(self.position)")
        }
    }
    
}





