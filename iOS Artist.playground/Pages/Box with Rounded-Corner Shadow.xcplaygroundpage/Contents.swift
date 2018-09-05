/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Understanding layers: A Box with Rounded-Corner Shadow
 
 Resources:
 [CALayer Tutorial for iOS: Getting Started](https://www.raywenderlich.com/402-calayer-tutorial-for-ios-getting-started)
 
 */
//MARK: Setup playground
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let baseView = UIView()
        baseView.backgroundColor = .yellow
        
        self.view = baseView
        
        let cardView = UIView()
        cardView.backgroundColor = .black
        
        // Configure the backed CALayer of the view:
        
        // This two lines work together to get the "rounded-corner" effect
        // for the UIView!
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true
        
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 32
        // Set masksToBounds to false to get the shadow to show on the layer
        cardView.layer.masksToBounds = false
        
        // At this jucture, baseView still has zero width and depth, so we
        // simply create a static frame
        cardView.frame = CGRect(x: 90, y: 100, width: 200, height: 200)
        baseView.addSubview(cardView)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
