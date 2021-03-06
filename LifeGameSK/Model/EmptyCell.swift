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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTap(cell: self)
    }

}





