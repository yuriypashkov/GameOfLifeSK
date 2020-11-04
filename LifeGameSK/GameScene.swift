import SpriteKit

var game: Game!

class GameScene: SKScene {
    
    
    
    var dataSource: [Cell] = [] {
        didSet {
            for i in 0..<arrayOfEmptyCell.count {
                arrayOfEmptyCell[i].configureWithState(dataSource[i].isAlive)
                
//                if arrayOfEmptyCell[i].isAlive && !dataSource[i].isAlive {
//                    print("MAKE LIVE CELL")
//                    dataSource[i] = Cell.makeLiveCell()
//                }
            }
        }
    }
    
    var arrayOfEmptyCell = [EmptyCell]()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = .systemOrange
        
        let w = self.size.width
        let h = self.size.height
        
        let cellCount = 40
        let cellWidth = w / 40
        
        createNodeOfCells(w: w, h: h, cellCount: cellCount, cellWidth: cellWidth)
        
        game = Game(width: cellCount, height: cellCount + 10)
        
        dataSource = game.generateInitialState().cells
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let state = game.iterate()
            self.display(state)
        }
        
    }
    
    func display(_ state: GameState) {
        dataSource = state.cells
    }
    
    func createNodeOfCells(w: CGFloat, h: CGFloat, cellCount: Int, cellWidth: CGFloat) {
        let testNode = SKNode()
        testNode.position = CGPoint(x: w/2, y: h/2)
        addChild(testNode)
        var position = 0
        for i in 0..<cellCount + 10 {
            for j in 0..<cellCount{
                let x = CGFloat(j) * cellWidth
                let y = CGFloat(i) * cellWidth                
                let emptyCell = EmptyCell(x: x, y: y, width: cellWidth, height: cellWidth, position: position)
                arrayOfEmptyCell.append(emptyCell)
                testNode.addChild(emptyCell)
                position += 1
            }
        }
        testNode.position = CGPoint(x: testNode.position.x - CGFloat(cellCount)*cellWidth/2, y: testNode.position.y - CGFloat(cellCount)*cellWidth/2)
    }
  
}
