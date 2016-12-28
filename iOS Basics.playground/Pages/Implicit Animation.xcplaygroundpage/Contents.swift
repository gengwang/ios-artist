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
            
            // Implicit animations are triggered when we modify the frame, opacity and path properties of a CAShapeLayer object:
            
            //            UIView.animate(withDuration: 1.0, animations: {
            self.touchVizLayer.frame.origin = firstTouch.location(in: self)
            self.touchVizLayer.opacity = 1
            
            let center = CGPoint(x: self.bounds.origin.x - CircleDrawer.BOX_WIDTH / 2, y: self.bounds.origin.y - CircleDrawer.BOX_HEIGHT / 2)
            let circle = UIBezierPath(ovalIn: CGRect(origin: center, size: CGSize(width: CircleDrawer.BOX_WIDTH, height: CircleDrawer.BOX_HEIGHT)))
            self.touchVizLayer.path = circle.cgPath
            
            self.touchVizLayer.fillColor = UIColor.purple.cgColor
            //            })
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            self.touchVizLayer.frame.origin = firstTouch.location(in: self)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchVizLayer.frame.origin = self.center
        self.touchVizLayer.opacity = 0.3
        let center = CGPoint(x: self.bounds.origin.x - CircleDrawer.BOX_WIDTH / 2, y: self.bounds.origin.y - CircleDrawer.BOX_HEIGHT / 2)
        let rect = UIBezierPath(rect: CGRect(origin: center, size: CGSize(width: CircleDrawer.BOX_WIDTH, height: CircleDrawer.BOX_HEIGHT)))
        touchVizLayer.path = rect.cgPath
        touchVizLayer.fillColor = UIColor.darkGray.cgColor
    }
    
    private func setup() {
        let touchVizLayer = CAShapeLayer()
        let center = CGPoint(x: self.bounds.origin.x - CircleDrawer.BOX_WIDTH / 2, y: self.bounds.origin.y - CircleDrawer.BOX_HEIGHT / 2)
        let rect = UIBezierPath(rect: CGRect(origin: center, size: CGSize(width: CircleDrawer.BOX_WIDTH, height: CircleDrawer.BOX_HEIGHT)))
        touchVizLayer.path = rect.cgPath
        touchVizLayer.frame.size = rect.bounds.size
        
        // debug
        //        touchVizLayer.borderWidth = 1
        //        touchVizLayer.borderColor = UIColor.blue.cgColor
        touchVizLayer.frame.origin = self.center
        touchVizLayer.opacity = 0.3
        // fill the host layer also fill its path
        touchVizLayer.fillColor = UIColor.darkGray.cgColor
        self.layer.addSublayer(touchVizLayer)
        self.touchVizLayer = touchVizLayer
    }
}


let cd = CircleDrawer(frame: CGRect(origin: CGPoint.zero, size: containerView.bounds.size))
cd.backgroundColor = UIColor.white
cd.isOpaque = true

containerView.addSubview(cd)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
