
import Foundation

struct Cell {

    var isAlive: Bool = false

    static func makeDeadCell() -> Cell {
        return Cell(isAlive: false)
    }

    static func makeLiveCell() -> Cell {
        return Cell(isAlive: true)
    }

}
