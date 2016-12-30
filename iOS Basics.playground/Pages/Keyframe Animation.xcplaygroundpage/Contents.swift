/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Keyframe Animation
 
 You use `CAKeyframeAnimation(keyPath:)` to create a keyframe animation object, whose `values` property stores the information about the "keyframes". To animate a sprite along a path, you can also use the `path` property to store the path information. Finally, to trigger the animation, the CALayer object needs to add the animation object to itself.
*/

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

PlaygroundPage.current.liveView = containerView

let grid = GridView(frame: CGRect(origin: containerView.bounds.origin, size: containerView.bounds.size))
grid.gridColor = UIColor.white
grid.lineWidth = 85
grid.isUserInteractionEnabled = false

class MyAppView: UIView {

    var sprite: CALayer!
    var liLayer: CAShapeLayer?
    
    private var positions: [CGPoint]!
    private var rotations: [CATransform3D]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(background: UIView) {
        self.init(frame: CGRect.zero)
        self.addSubview(background)

        let spriteLayer = emojiLayer("☃️")

        positions = [
            CGPoint(x: 200, y: 200)
            ,CGPoint(x: 300, y: 200)
            ,CGPoint(x: 300, y: 300)
            ,CGPoint(x: 0, y: 300)
            ,CGPoint(x: 0, y: 0)
            ,CGPoint(x: 200, y: 0)
            ,CGPoint(x: 200, y: 200)
            ,CGPoint(x: 200, y: 180)
            ,CGPoint(x: 200, y: 200)
        ]
        let tiltWest = CATransform3DRotate(spriteLayer.transform, -CGFloat.pi/3, 0.0, 0.0, 1.0)
        let tiltEast = CATransform3DRotate(spriteLayer.transform, CGFloat.pi/3, 0.0, 0.0, 1.0)
        let tiltNone = CATransform3DRotate(spriteLayer.transform, CGFloat.pi/3, 0.0, 0.0, 0.0)

        rotations = [
            tiltWest
            ,tiltNone
            ,tiltEast
            ,tiltNone
            ,tiltWest
            ,tiltNone
            ,tiltNone
            ,tiltNone
            ,tiltNone
        ]
        
        
        let liLayer = lineLayer(positions, color: UIColor.lightGray, lineWidth: 12)
        self.layer.addSublayer(liLayer)
        self.liLayer = liLayer
        
        self.layer.addSublayer(spriteLayer)
        
//        spriteLayer.transform = tiltWest
        self.sprite = spriteLayer
        spriteLayer.position = positions[0]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.sprite.removeAllAnimations()
        
        let pathKeysAnim = CAKeyframeAnimation(keyPath: "position")
        // As an alternaltive to the "path" property, you can also use "values" to store the sequence of position information
//        pathKeysAnim.values = self.positions
        pathKeysAnim.path = self.liLayer?.path
//        pathKeysAnim.rotationMode = kCAAnimationRotateAuto
//        pathKeysAnim.isAdditive = true
        
        let tiltKeysAnim = CAKeyframeAnimation(keyPath: "transform")
        tiltKeysAnim.values = self.rotations
        
        let spriteKeysAnim = CAAnimationGroup()
        spriteKeysAnim.animations = [pathKeysAnim, tiltKeysAnim]
        spriteKeysAnim.duration = 2.4
        spriteKeysAnim.fillMode = kCAFillModeForwards
        spriteKeysAnim.isRemovedOnCompletion = false
        
        self.sprite.add(spriteKeysAnim, forKey: nil)
        
    }
}

let appView = MyAppView(background: grid)
appView.backgroundColor = UIColor.init(hue: 1.0, saturation: 1.0, brightness: 0.8, alpha: 1)
appView.frame = containerView.bounds

containerView.addSubview(appView)

/*:
****
[Previous](@previous) | [Next](@next)
*/
