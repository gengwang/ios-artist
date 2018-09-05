/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Three Boxes

 Here we switch between the three-box and two-box state on the screen. At the time of writing iOS doesn't have the concept of `view state` as in [Flex](http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf63611-7ffa.html) or `visual state` as in [WPF](https://blogs.msdn.microsoft.com/wpfsdk/2009/02/27/the-visualstatemanager-and-triggers/).
 
 Resoureces:
 - [WWDC 2014: What's New in Interface Builder](https://developer.apple.com/videos/play/wwdc2014/411/)
 - [Sample Code: AstroLayout](https://developer.apple.com/library/content/samplecode/AstroLayout/Introduction/Intro.html)
 - [Auto Layout Visual Format Language Tutorial](https://www.raywenderlich.com/110393/auto-layout-visual-format-language-tutorial)
 
*/
import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    var topLeftView: UIView = {
        return UIView.viewWith(backgroundColor: UIColor.init(red: 67/255, green: 255/255, blue: 84/255, alpha: 1.0))
    }()
    var topRightView: UIView = {
        return UIView.viewWith(backgroundColor: UIColor.init(red: 255/255, green: 255/255, blue: 103/255, alpha: 1.0))
    }()
    var bottomView: UIView = {
        return UIView.viewWith(backgroundColor: UIColor.init(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0))
    }()
    
    var twoBoxConstraints = [NSLayoutConstraint]()
    var threeBoxConstraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(topLeftView)
        view.addSubview(topRightView)
        view.addSubview(bottomView)
        
        setUpConstraints()
        
        setUpGestures()
    }
    func setUpConstraints() {
        
        topLeftView.translatesAutoresizingMaskIntoConstraints = false
        topRightView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        // shared constraints by both two and three boxes states
        let bottomBoxHorizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bottomView])
        let topTwoBoxHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-[v1(==v0)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topLeftView, "v1": topRightView])
        
        // constraints unique to the two-box state
        let twoBoxVerticalConstraintLeftBox = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(==0)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topLeftView, "v1": bottomView])
        let twoBoxVerticalConstraintRightBox = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(==0)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topRightView, "v1": bottomView])
        
        if twoBoxConstraints.count == 0 {
            twoBoxConstraints += twoBoxVerticalConstraintLeftBox +
                twoBoxVerticalConstraintRightBox +
                topTwoBoxHorizontalConstraints +
            bottomBoxHorizontalConstraint
        }
        
        // constraints unique to the three-box state
        let threeBoxVerticalConstraintLeftBox = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(==v0)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topLeftView, "v1": bottomView])
        let threeBoxVerticalConstraintRightBox = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(==v0)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": topRightView, "v1": bottomView])
        
        if threeBoxConstraints.count == 0 {
            threeBoxConstraints += threeBoxVerticalConstraintLeftBox +
                threeBoxVerticalConstraintRightBox +
                topTwoBoxHorizontalConstraints +
            bottomBoxHorizontalConstraint
        }
        
        NSLayoutConstraint.activate(threeBoxConstraints)
    }
    func setUpGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.changeLayout(gesture:)))
        view.addGestureRecognizer(tap)
    }
    @objc func changeLayout(gesture: UIGestureRecognizer) {
        // Since we are not exposing individual constraint in each state, make sure that we pick a constraint unique to that state
        let twoBoxConstraint = twoBoxConstraints.first
        let threeBoxConstraint = threeBoxConstraints.first
        
        if (twoBoxConstraint?.isActive)! {
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                () in
                NSLayoutConstraint.deactivate(self.twoBoxConstraints)
                NSLayoutConstraint.activate(self.threeBoxConstraints)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }else if (threeBoxConstraint?.isActive)! {
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                () in
                NSLayoutConstraint.deactivate(self.threeBoxConstraints)
                NSLayoutConstraint.activate(self.twoBoxConstraints)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}

PlaygroundPage.current.liveView = ViewController()

/*:
 ****
 [Previous](@previous) | [Next](@next)
*/
