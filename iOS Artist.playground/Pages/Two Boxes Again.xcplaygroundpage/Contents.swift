/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Two Boxes, Again
 
 */
import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    var greenView: UIView = {
        return UIView.viewWith(backgroundColor: UIColor.init(red: 67/255, green: 255/255, blue: 84/255, alpha: 1.0))
    }()
    var blueView: UIView = {
        return UIView.viewWith(backgroundColor: UIColor.init(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0))
    }()
    var orangeView: UIView = {
        let view = CircleView()
        view.color = UIColor.init(red: 255/255, green: 128/255, blue: 0/255, alpha: 1.0)
        // Debug
        //        view.backgroundColor = UIColor.black
        return view
    }()
    
    var greenViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(greenView)
        view.addSubview(blueView)
        greenView.addSubview(orangeView)
        
        setUpConstraints()
        setUpGestures()
    }
    // When, for example, the device orientation is about to change, we need to re-caculate the hight for the green view so that it still takes half of the vertical space when the orientation change has occurred.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        animateGreenViewToHeight(height: size.height * 0.5, duration: 0.33)
    }
    func setUpConstraints() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        
        greenViewHeightConstraint = NSLayoutConstraint.init(item: greenView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.frame.height * 0.5)
        
        let greenViewTopConstraint = NSLayoutConstraint.init(item: greenView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        let blueViewTopConstraint = NSLayoutConstraint.init(item: blueView, attribute: .top, relatedBy: .equal, toItem: greenView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        let blueViewBottomConstraint = NSLayoutConstraint.init(item: blueView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        let views = ["greenView": greenView, "blueView": blueView, "orangeView": orangeView]
        
        let greenViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[greenView]|", options: [], metrics: nil, views: views)
        
        let blueViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[blueView]|", options: [], metrics: nil, views: views)
        
        if let tC = greenViewHeightConstraint {
            let verticalConstraints = [greenViewTopConstraint, tC, blueViewTopConstraint, blueViewBottomConstraint]
            
            let constraints =  verticalConstraints
                + greenViewHorizontalConstraints
                + blueViewHorizontalConstraints
            
            NSLayoutConstraint.activate(constraints)
        }
        // We prefer that the size (width/height) of the circle is no smaller than 30 px.
        let orangeViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[orangeView(>=30@759)]-50-|", options: [], metrics: nil, views: views)
        let orangeViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[orangeView(>=30@759)]-50-|", options: [], metrics: nil, views: views)
        let constraints2 =
            orangeViewHorizontalConstraints
                + orangeViewVerticalConstraints
        NSLayoutConstraint.activate(constraints2)
    }
    override func viewWillLayoutSubviews() {
        orangeView.setNeedsDisplay()
    }
    func setUpGestures() {
        let tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.didTap(tapRecognizer:)))
        tapRecognizer.minimumPressDuration = 0.0
        view.addGestureRecognizer(tapRecognizer)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPan(panRecognizer:)))
        view.addGestureRecognizer(panRecognizer)
    }
    func animateGreenViewToHeight(height: CGFloat, duration: TimeInterval = 0.25) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: duration, animations: {
            self.greenViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        })
    }
    func didTap(tapRecognizer: UIGestureRecognizer) {
        if tapRecognizer.state == UIGestureRecognizerState.ended {
            animateGreenViewToHeight(height: self.view.frame.height * 0.5, duration: 0.33)
        }else {
            let touchPoint = tapRecognizer.location(in: view)
            animateGreenViewToHeight(height: touchPoint.y)
        }
    }
    func didPan(panRecognizer: UIGestureRecognizer) {
        let touchPoint = panRecognizer.location(in: view)
        animateGreenViewToHeight(height: touchPoint.y)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

PlaygroundPage.current.liveView = ViewController()


/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
