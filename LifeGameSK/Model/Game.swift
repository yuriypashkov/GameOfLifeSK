import Foundation

class Game {
    
    let width: Int
    let height: Int
    var currentState: GameState
    //var indexPath: [IndexPath] = []
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let cells = Array(repeating: Cell.makeDeadCell(), count: width * height)
        currentState = GameState(cells: cells)
    }
    
    func setTappedCellLive(_ i: Int) {
        currentState[i] = Cell.makeLiveCell()
    }
    
    func reset() {
        generateInitialState()
    }
    
    func iterate() -> GameState {

        var nextState = currentState
        
        for i in 0..<width {
            for j in 0..<height {
                let positionInTheArray = j * width + i
                nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
            }
        }
        
        currentState = nextState
        return nextState
    }
    
    func state(x: Int, y: Int) -> Bool {
        let numberOfAliveNeighbours = aliveNeighbourCountAt(x: x, y: y)
        let position = x + y * width
        let wasPrevioslyAlive = currentState[position].isAlive
        
        if wasPrevioslyAlive {
            return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        } else {
            return numberOfAliveNeighbours == 3
        }
    }
    
    func aliveNeighbourCountAt(x: Int, y: Int) -> Int {
        var numberOfAliveNeighbours = 0
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                
                if (i == x && y == j) || (i >= width) || (i < 0) || (j < 0 ) {continue}
                let index = j * width + i
                guard index >= 0 && index < width * height else {continue}
                if currentState[index].isAlive { numberOfAliveNeighbours += 1 }
            }
        }
        return numberOfAliveNeighbours
    }
    
    func setInitialState(_ state: GameState) {
        currentState = state
    }
    
    @discardableResult
    func generateInitialState() -> GameState {
        let maxItems = width * height - 1
        let initialStatePoints = generateRandom(between: 0...maxItems, count: maxItems / 8)

        for point in initialStatePoints {
            currentState[point] = Cell.makeLiveCell()
        }
        return currentState
    }
    
    private func generateRandom(between range: ClosedRange<Int>, count: Int) -> [Int] {
        return Array(0...count).map { _ in
            Int.random(in: range)
        }
    }
    
}
