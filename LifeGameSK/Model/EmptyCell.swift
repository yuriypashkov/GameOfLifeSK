//
// This is SpriteKit model for game cell
// Not Dead or Live cell
//

import SpriteKit

protocol EmptyCellDelegate: class {
    func didTap(cell: EmptyCell)
}

class EmptyCell: SKShapeNode {

    var positionInArray: Int?
    
    weak var delegate: EmptyCellDelegate!
    
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
    
    // method for single tap on emptyCell
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTap(cell: self)
    }
    
    // try to create method for moved toches, but not have idea
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                   let location = touch.location(in: self)
                   print("Touch location is \(location) AND cell position is \(self.position)")
        }
    }

}





