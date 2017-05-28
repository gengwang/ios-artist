import UIKit

public class ViewController: UIViewController {
    static let digitWidth: CGFloat = 150
    static let digitHeight: CGFloat = 180
    
    class DigitLayer: CATextLayer {
        var digit: String = ""
        var backdropLayer: CALayer!
        var textLayer: CATextLayer!
        var perspectiveAnchorPoint = CGPoint(x: 0.5, y: 0.5)
        var backdropPopInOutAnimation: CAAnimationGroup!
        var textPopInOutAnimation: CAAnimationGroup!
        
        init(digit: String) {
            super.init()
            self.digit = digit
            
            let backdrop = CALayer()
            backdrop.frame = CGRect(x: 0, y: 0, width: digitWidth, height: digitHeight)
            // We want the "pop" effect to appear from the center of the layer. To make this work, first we need to set the anchor point of the object to be at its center CGPoint(x: 0.5, y: 0.5),
            backdrop.anchorPoint = perspectiveAnchorPoint
            // Then we move the layer to the center of the screen by settings its position.
            backdrop.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
            backdrop.backgroundColor = UIColor.gray.cgColor
            backdrop.cornerRadius = 6
            backdrop.opacity = 0
            self.backdropLayer = backdrop
            self.addSublayer(backdrop)
            
            let text = CATextLayer()
            text.string = digit
            text.frame = backdrop.bounds
            text.anchorPoint = perspectiveAnchorPoint
            text.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
            text.alignmentMode = kCAAlignmentCenter
            text.foregroundColor = UIColor.white.cgColor
            text.fontSize = 150
            text.contentsScale = UIScreen.main.scale
            text.opacity = 0
            self.textLayer = text
            self.addSublayer(text)
            
            // 3d perspective
            var perspective = CATransform3DIdentity
            // Setting up CATransform3D.m34 will enable the "3D perspective". Layers with negative values at the z axis will appear farther away from the user's eye
            perspective.m34 = 1 / -500
            // All sublayers will share the same 3d perspective
            self.sublayerTransform = perspective
            
            // Set up animations
            let animationDuration: CFTimeInterval = 2.0
            
            // Set up animations for backdropLayer
            let backdropKeyTimes: [NSNumber] = [0.0, 0.25, 1.0]
            let backdropZoomInOut = CAKeyframeAnimation(keyPath: "transform")
            backdropZoomInOut.values = [
                CATransform3DTranslate(CATransform3DIdentity, 0, 0, 300),
                CATransform3DIdentity,
                CATransform3DTranslate(CATransform3DIdentity, 0, 0, -6600)
            ]
            backdropZoomInOut.keyTimes = backdropKeyTimes
            backdropZoomInOut.timingFunctions = [
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            ]
            
            let backdropFadeInOut = CAKeyframeAnimation(keyPath: "opacity")
            backdropFadeInOut.values = [0, 1, 0]
            backdropFadeInOut.keyTimes = backdropKeyTimes
            
            let backdropAnimation = CAAnimationGroup()
            backdropAnimation.duration = animationDuration
            backdropAnimation.animations = [
                backdropZoomInOut,
                backdropFadeInOut
            ]
            // Fill the end value of the animation for the presentation layer tree towards the end
            backdropAnimation.fillMode = kCAFillModeForwards
            // Don't remove the animation when it's completed; effectively the presentation layer tree will stick around
            backdropAnimation.isRemovedOnCompletion = false
            self.backdropPopInOutAnimation = backdropAnimation
            
            // Set up animations for textLayer
            let textKeyTimes: [NSNumber] = [0.0, 0.3, 1.0]
            let textZoomInOut = CAKeyframeAnimation(keyPath: "transform")
            textZoomInOut.values = [
                CATransform3DTranslate(CATransform3DIdentity, 0, 0, 300),
                CATransform3DTranslate(CATransform3DIdentity, 0, 0, 1),
                CATransform3DTranslate(CATransform3DIdentity, 0, 0, -6100)
            ]
            textZoomInOut.keyTimes = textKeyTimes
            textZoomInOut.timingFunctions = [
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault),
                CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            ]
            
            let textFadeInOut = CAKeyframeAnimation(keyPath: "opacity")
            textFadeInOut.values = [0, 1, 0]
            textFadeInOut.keyTimes = textKeyTimes
            
            let textAnimation = CAAnimationGroup()
            textAnimation.duration = animationDuration
            textAnimation.animations = [
                textZoomInOut,
                textFadeInOut
            ]
            textAnimation.fillMode = kCAFillModeForwards
            textAnimation.isRemovedOnCompletion = false
            self.textPopInOutAnimation = textAnimation
        }
        func popIn() {
            backdropLayer.removeAnimation(forKey: "pop")
            backdropPopInOutAnimation.timeOffset = 0.0
            backdropPopInOutAnimation.repeatCount = 0.25
            backdropLayer.add(backdropPopInOutAnimation, forKey: "pop")
            
            textLayer.removeAnimation(forKey: "pop")
            textPopInOutAnimation.timeOffset = 0
            textPopInOutAnimation.repeatCount = 0.3
            textLayer.add(textPopInOutAnimation, forKey: "pop")
        }
        func popOut() {
            backdropLayer.removeAnimation(forKey: "pop")
            
            // Set the beginning of the animation at the 0.5 sec mark
            backdropPopInOutAnimation.timeOffset = 0.5
            // Set the length of the animation 75% of the total length, and since we start at 0.5 sec and the total animation is 2 sec in length, this will give us animation of 2 * 0.75 = 1.5 sec, which will start from 0.5 sec and end at 2.0 sec
            backdropPopInOutAnimation.repeatCount = 0.75
            
            // This effectively plays the animation (again)
            backdropLayer.add(backdropPopInOutAnimation, forKey: "pop")
            
            textLayer.removeAnimation(forKey: "pop")
            textPopInOutAnimation.timeOffset = 0.6
            textPopInOutAnimation.repeatCount = 0.7
            textLayer.add(textPopInOutAnimation, forKey: "pop")
        }
        
        override init() {
            super.init()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    var dLayer: DigitLayer!
    let initialFrame = CGRect(x: 300, y: 200, width: 100, height: 100)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        print("view did load...")
        // Since we are in Playground, we manually set the view size
        self.view.frame = CGRect(x: 0, y: 0, width: 400, height: 600)
        self.view.backgroundColor = UIColor.black
        
        let digitLayer = DigitLayer(digit: "A")
        self.dLayer = digitLayer
        self.view.layer.addSublayer(digitLayer)
        center()
    }
    
    func center() {
//        let screenBounds = UIScreen.main.bounds
        let bounds = self.view.bounds
        let xPos = (bounds.width)/2
        let yPos = (bounds.height)/2
        dLayer.position = CGPoint(x: xPos, y: yPos)
    }
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began...")
        dLayer.popIn()
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch ended...")
        dLayer.popOut()
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
