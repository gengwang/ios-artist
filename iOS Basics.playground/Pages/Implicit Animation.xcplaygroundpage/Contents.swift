/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Implicit Animation
 
When you update the properties of a layer object, Core Animation uses your changes to create and schedule one or more implicit animations, while the changes are reflected immediately by those objects.
 
 */
import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 600)))
containerView.backgroundColor = UIColor.black
PlaygroundPage.current.liveView = containerView

class CircleDrawer: UIView {
    var touchVizLayer: CAShapeLayer!
    
    static let BOX_WIDTH: CGFloat = 40
    static let BOX_HEIGHT: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            
            // Implicit animations are triggered when we modify the position, opacity and path properties of a CAShapeLayer object:
            
            //            UIView.animate(withDuration: 1.0, animations: {
            self.touchVizLayer.position = firstTouch.location(in: self)
            self.touchVizLayer.opacity = 1
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: CGSize(width: CircleDrawer.BOX_WIDTH, height: CircleDrawer.BOX_HEIGHT)))
            self.touchVizLayer.path = circle.cgPath
            self.touchVizLayer.fillColor = UIColor.purple.cgColor
            //            })
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            self.touchVizLayer.position = firstTouch.location(in: self)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchVizLayer.position = self.center
        self.touchVizLayer.opacity = 0.3
        let rect = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: CGSize(width: CircleDrawer.BOX_WIDTH, height: CircleDrawer.BOX_HEIGHT)))
        touchVizLayer.path = rect.cgPath
        touchVizLayer.bounds.size = rect.bounds.size
        touchVizLayer.fillColor = UIColor.darkGray.cgColor
    }
    
    private func setup() {
        let touchVizLayer = CAShapeLayer()
        let rect = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: CGSize(width: CircleDrawer.BOX_WIDTH, height: CircleDrawer.BOX_HEIGHT)))
        touchVizLayer.path = rect.cgPath
        // This effectively sets the layer's size as well as it's anchorPoint the center of the bounds (by default, anchorPoint is (x: 0.5, y: 0.5). Without this step, the anchor point would have been CGPoint.zero since the bounds was CGRect.zero.
        touchVizLayer.bounds.size = rect.bounds.size
        touchVizLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Debug
//        touchVizLayer.borderWidth = 1
        
        // Move the layer to the center of the host view
        touchVizLayer.position = self.center
        touchVizLayer.opacity = 0.3
        // Fill the host layer also fill its path
        touchVizLayer.fillColor = UIColor.darkGray.cgColor
        self.layer.addSublayer(touchVizLayer)
        self.touchVizLayer = touchVizLayer
    }
}

let rect = CGRect(origin: CGPoint.zero, size: containerView.bounds.size)

let cd = CircleDrawer(frame: rect)
cd.backgroundColor = UIColor.white
cd.isOpaque = true

containerView.addSubview(cd)

// Debug
let grid = GridView(frame: rect)
grid.step = rect.width/4
grid.gridColor = UIColor.lightGray
grid.isUserInteractionEnabled = false
containerView.addSubview(grid)
/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
