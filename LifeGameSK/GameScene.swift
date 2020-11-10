import SpriteKit

class GameScene: SKScene, EmptyCellDelegate {
    
    func didTap(cell: EmptyCell) {
        game.setTappedCellLive(cell.positionInArray!)
        cell.configureWithState(true)
    }

    var dataSource: [Cell] = [] {
        didSet {
            for i in 0..<arrayOfEmptyCell.count {
                arrayOfEmptyCell[i].configureWithState(dataSource[i].isAlive)
            }
        }
    }
    
    var game: Game!
    
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
            let state = self.game.iterate()
            self.display(state)
        }
        
    }
    
    func display(_ state: GameState) {
        dataSource = state.cells
    }
    
    let testNode = SKNode()
    
    func createNodeOfCells(w: CGFloat, h: CGFloat, cellCount: Int, cellWidth: CGFloat) {
        
        testNode.position = CGPoint(x: w/2, y: h/2)
        addChild(testNode)
        var position = 0
        for i in 0..<cellCount + 10 {
            for j in 0..<cellCount{
                let x = CGFloat(j) * cellWidth
                let y = CGFloat(i) * cellWidth                
                let emptyCell = EmptyCell(x: x, y: y, width: cellWidth, height: cellWidth, position: position)
                emptyCell.delegate = self
                arrayOfEmptyCell.append(emptyCell)
                testNode.addChild(emptyCell)
                position += 1
            }
        }
        testNode.position = CGPoint(x: testNode.position.x - CGFloat(cellCount)*cellWidth/2, y: testNode.position.y - CGFloat(cellCount)*cellWidth/2)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        if let touchNode = selectNodeForTouch(location) {
            didTap(cell: touchNode)
        }
    }
    
    func selectNodeForTouch(_ point: CGPoint) -> EmptyCell? {
        return (self.atPoint(point) as? EmptyCell)
    }
  
}


