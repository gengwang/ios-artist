/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Plus Button 1: Basic composition
 
 Composition is one of the basic techiques in design. The idea here is to draw several CALayer objects in a signle control so that we can cheograph their UI states while maintaining grainular control of individual layers.
*/

import UIKit
import PlaygroundSupport

let appTintColor = UIColor.red

class PlusButton: UIControl {
    
    class PushButtonLayer: CALayer {
        var isTouchDown: Bool = false {
            didSet(newValue) {
                // Gothca: This doesn't work.
//                if newValue { setNeedsDisplay() }
                setNeedsDisplay()
            }
        }
    }
    
    class CircleLayer: PushButtonLayer {
        override func draw(in ctx: CGContext) {
            UIGraphicsPushContext(ctx)
            let margin: CGFloat = 4
            let w = self.bounds.width - 2 * margin
            let h = self.bounds.height - 2 * margin
            let bounds = CGRect(x: margin, y: margin, width: w, height: h)
            let path = UIBezierPath(ovalIn: bounds)
            let fillColor = isTouchDown ? appTintColor.withAlphaComponent(0.5) : appTintColor.withAlphaComponent(0.3)
            fillColor.setFill()
            path.fill()
            
            let lineWidth = CGFloat(3)
            path.lineWidth = lineWidth
            let strokeColor = appTintColor
            strokeColor.setStroke()
            path.stroke()
            UIGraphicsPopContext()
        }
    }
    class PlusLayer: PushButtonLayer {
        override func draw(in ctx: CGContext) {
            UIGraphicsPushContext(ctx)
            let margin: CGFloat = isTouchDown ? 21 : 20
            let w = self.bounds.width - 2 * margin
            let h = self.bounds.height - 2 * margin
            let path = UIBezierPath()
            // Draw the horizontal line
            path.move(to: CGPoint(x: margin, y: h/2 + margin))
            path.addLine(to: CGPoint(x: w + margin, y: h/2 + margin))
            // Draw the vertical line
            path.move(to: CGPoint(x: margin + w/2, y: margin))
            path.addLine(to: CGPoint(x: margin + w/2, y: margin + h))
            
            let lineWidth = isTouchDown ? CGFloat(6) : CGFloat(5)
            path.lineWidth = lineWidth
            let strokeColor = appTintColor
            strokeColor.setStroke()
            path.stroke()

            UIGraphicsPopContext()
        }
    }
    
    var circle: CircleLayer!
    var circleOriginalBounds: CGRect!
    var plus: PlusLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        circle = CircleLayer()
        circle.frame = self.bounds
        circleOriginalBounds = circle.bounds
        
        // When adding a layer to a control, we need to explicitly send the `display` or `setNeedsDisplay` message to the layer object make it visible in the render tree.
        circle.display()
        
        self.layer.addSublayer(circle)
        plus = PlusLayer()
        plus.frame = self.bounds
        self.layer.addSublayer(plus)
        plus.display()
        
        addTarget(self, action: #selector(PlusButton.touchDown(sender:)), for: .touchDown)
        addTarget(self, action: #selector(PlusButton.touchUpInside(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(PlusButton.touchDragExit(sender:)), for: .touchDragExit)
    }
    @objc func touchDown(sender: AnyObject) {
        circle.isTouchDown = true
        let offset = CGFloat(24)//12
        let w = circleOriginalBounds.width + offset
        let h = circleOriginalBounds.height + offset
        
        let newBounds = CGRect(origin: CGPoint.zero, size: CGSize(width: w, height: h))
        
        // CALayer's bounds property is animatable. Had we drawn an oval with two different sizes based on the current touchDown state in the draw(_:) method of the CircleLayer object instead, we would have the default animation where one circle dissolves to another one.
        
        // Since we are using a custom Core animation object (sprint damping) for touch up inside, we can't simply say: circle.bounds = newBounds anymore; instead, we need to create another animation object:

        let grow = CABasicAnimation(keyPath: "bounds")
        grow.fromValue = circle.bounds
        grow.toValue = newBounds
        grow.fillMode = kCAFillModeForwards
        grow.isRemovedOnCompletion = false
        circle.add(grow, forKey: "grow")
        
        plus.isTouchDown = true
    }
    @objc func touchUpInside(sender: AnyObject) {
        circle.isTouchDown = false
//        circle.bounds = circleOriginalBounds

        let spring = CASpringAnimation(keyPath: "bounds")
        spring.damping = 5
        spring.toValue = circleOriginalBounds
        spring.duration = spring.settlingDuration
        spring.fillMode = kCAFillModeForwards
        spring.isRemovedOnCompletion = false
        circle.add(spring, forKey: "damp")
        
        plus.isTouchDown = false
    }
    @objc func touchDragExit(sender: AnyObject) {
        circle.isTouchDown = false
        
//        circle.bounds = circleOriginalBounds
        let shrink = CABasicAnimation(keyPath: "bounds")
        shrink.toValue = circleOriginalBounds
        shrink.fillMode = kCAFillModeForwards
        shrink.isRemovedOnCompletion = false
        circle.add(shrink, forKey: "shrink")
        
        plus.isTouchDown = false

    }
}

let w: CGFloat = 300
let h: CGFloat = 300
let r: CGFloat = 50
let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: w, height: 300)))
PlaygroundPage.current.liveView = containerView

let center = CGPoint(x: w/2 - r, y: h/2 - r)
let plusButton = PlusButton(frame: CGRect(origin: center, size: CGSize(width: 2*r, height: 2*r)))
containerView.addSubview(plusButton)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
