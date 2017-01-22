/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Animation: Drawing a circle
 
 The basics for animating a custom drawn view are as follows:
 - An instance of `CAShapeLayer` is added to the view's layer
 - One way of custom drawing is to implement the `draw(_ rect: CGRect)` in a view object, in which you draw paths as the `CAShapeLayer.path`
 - To configure the to animation, use `CABasicAnimation(keyPath: "path")` and assign a new path to the `CABasicAnimation.toValue`
 - To start the animation, use `CAShapeLayer.add(CAAnimation forKey)` in the `draw(rect)` method in the view

*/

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 600)))
containerView.backgroundColor = UIColor.gray

PlaygroundPage.current.liveView = containerView

class CircleDrawer: UIView {
    
    private var shapeLayer: CAShapeLayer!
    private var circleStartPoint: CGPoint?
    private var circleEndPoint: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        self.layer.addSublayer(shapeLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            circleStartPoint = firstTouch.location(in: self)
            circleEndPoint = circleStartPoint
            setNeedsDisplay()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            self.circleEndPoint = firstTouch.location(in: self)
            setNeedsDisplay()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.circleEndPoint = self.circleStartPoint
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let start = circleStartPoint, let end = circleEndPoint {
            
            
            let xDist = end.x - start.x
            let yDist = end.y - start.y
            let toRadius = sqrt( xDist * xDist ) + sqrt( yDist * yDist )
            let maxDist = sqrt(self.bounds.width*self.bounds.width + self.bounds.height*self.bounds.height)
            let opacity = max(1 - (toRadius / maxDist), 0)
            
            let fromOval = UIBezierPath(arcCenter: start, radius: toRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
            
            fromOval.stroke()
            UIColor.magenta.setFill()
            fromOval.fill()
            shapeLayer.path = fromOval.cgPath
            shapeLayer.opacity = Float(opacity)
            
            let toOval = UIBezierPath(arcCenter: start, radius: toRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
            
            let radiusAnimation = CABasicAnimation(keyPath: "path")
            
            radiusAnimation.toValue = toOval.cgPath
            radiusAnimation.duration = 0.333
            radiusAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            radiusAnimation.fillMode = kCAFillModeForwards
            radiusAnimation.isRemovedOnCompletion = false
            
            shapeLayer.add(radiusAnimation, forKey: nil)
            
            //            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            //
            //            opacityAnimation.toValue = opacity
            //            opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            //            opacityAnimation.fillMode = kCAFillModeForwards
            //            opacityAnimation.isRemovedOnCompletion = false
            
            //            shapeLayer.add(opacityAnimation, forKey: "opacity")
            
            let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
            fillColorAnimation.toValue = UIColor.magenta.withAlphaComponent(opacity).cgColor
            fillColorAnimation.duration = 0.333
            fillColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            fillColorAnimation.fillMode = kCAFillModeForwards
            fillColorAnimation.isRemovedOnCompletion = false
            
            shapeLayer.add(fillColorAnimation, forKey: nil)
        }
    }
}


let cd = CircleDrawer(frame: CGRect(origin: CGPoint.zero, size: containerView.bounds.size))
cd.backgroundColor = UIColor.white

containerView.addSubview(cd)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
