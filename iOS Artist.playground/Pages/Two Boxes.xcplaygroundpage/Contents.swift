/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Two Boxes
 
 Here we draw two boxes, one on top of another, with the top one maintaining a height of 100 pixels and the bottom one filling the rest of the available room. Both boxes fill the available width.
 */
import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    // 1. Initialize the subview; note that its frame is not important here as we are going to use constraint based layout (i.e., auto layout) to set the position and size of the view
    var topView: UIView = {
        let view = UIView(frame: .zero)
        let blue = UIColor.init(red: 0/255, green: 102/255, blue: 153/255, alpha: 1.0)
        view.backgroundColor = blue
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 2. Add the subview to the view hierarchy
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        // 3. Set translatesAutoresizingMaskIntoConstraints to false on the view
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. Add constraint for both vertical and horizontal directions
        // Constraints on the horizontal direction
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bottomView]))
        // Constraints on the vertical direction
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0(100)]-20-[v1]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topView, "v1": bottomView]))
        
        // Note the frames for both views are still (0 0; 0 0)
        print("top: \(topView); bottom: \(bottomView)")
    }
    
}

PlaygroundPage.current.liveView = ViewController()

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
