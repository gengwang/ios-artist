/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Drawing: A Green Circle
 
 The basic way of custom drawing with [Core Graphics](https://developer.apple.com/reference/coregraphics#overview) is to override the UIView's `draw(_ rect:)` method.
 
 */
//MARK: Setup playground

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300)))
containerView.backgroundColor = UIColor.gray

PlaygroundPage.current.liveView = containerView

//MARK: custom view

class MyCircle: UIView {
    
    private func setup() {
        // To clear the default black background, set the background color property to the "clear" color or isOpaque to false.
//        self.backgroundColor = UIColor.clear
        self.isOpaque = false
    }
    // Implements draw(_ rect:) method
    override func draw(_ rect: CGRect) {
            print(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        
        path.fill()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

//MARK: Main

let w = CGFloat(88.0)
let h = CGFloat(88.0)
let x = (containerView.bounds.width - w) / 2
let y = (containerView.bounds.width - h) / 2

let circle = MyCircle(frame: CGRect(x: x, y: y, width: w, height: h))

containerView.addSubview(circle)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
