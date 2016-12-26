/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Touch Events 1
 
 To handle touch events in a view, implements the following methods:
 - `touchesBegan(_:with:)`
 - `touchesMoved(_:with:)`
 - `touchesEnded(_:with:)`
 - `touchesCancelled:withEvent:`
 
 The `isMultipleTouchEnabled` property is set to `false` by default.
 
 See details in [handling multitouch events.](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/multitouch_background/multitouch_background.html)
 
 */

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 600)))

PlaygroundPage.current.liveView = containerView

class MultitouchPlayground: UIView {
    // Used to monitor touchesBegan: and touchesEnd:
    var foo: UILabel!
    // Used to monitor touchesMoved:
    var foo2: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        self.isMultipleTouchEnabled = true
        
        let fooText = UILabel(frame: CGRect(x: 10, y: 2, width: 180, height: 240))
        
        fooText.text = ""
        fooText.numberOfLines = 12
        foo = fooText
        self.addSubview(foo)
        
        let fooText2 = UILabel(frame: CGRect(x: 210, y: 2, width: 180, height: 240))
        
        fooText2.text = ""
        fooText2.numberOfLines = 12
        foo2 = fooText2
        self.addSubview(foo2)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        clearTextIfTooLong()
        foo.text?.append("\nDown \(touches.count) finger(s)")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        clearTextIfTooLong()
        foo2.text?.append("\nMoved \(touches.count) finger(s)")
    }
    // event?.allTouches contain all the touch objects before a finger is lifted
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        clearTextIfTooLong()
        foo.text?.append("\nLift \(touches.count) finger(s)")
    }
    private func clearTextIfTooLong() {
        if let numberOfChars = foo.text?.characters.count {
            if numberOfChars > 160 {
                foo.text = ""
            }
        }
        if let numberOfChars = foo2.text?.characters.count {
            if numberOfChars > 160 {
                foo2.text = ""
            }
        }
    }
    
}


let tw = MultitouchPlayground(frame: CGRect(origin: CGPoint.zero, size: containerView.bounds.size))
tw.backgroundColor = UIColor.yellow

containerView.addSubview(tw)
/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
