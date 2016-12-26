/*: 
 [Previous](@previous) | [Next](@next)
****
 # Trivial MVC
 
 [Model-View-Controller](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html) design pattern is commonly used in choreographying user interface components in a Cocoa application.
 
 */
// MARK: Set up for UI in Playground

import Foundation
import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 480, height: 480))
containerView.backgroundColor = UIColor.blue
PlaygroundPage.current.liveView = containerView

//MARK: View Controller

class MyController: AnyObject {
    
    //MAKR: Model
    
    var isOn: Bool = false {
        didSet {
            updateStates()
        }
    }
    
    //MARK: Views
    
    var toggle: ToggleButton!
    var button: UIButton!
    var swit: UISwitch!
    
    required init(toggle: ToggleButton, button: UIButton, swit: UISwitch) {
        self.toggle = toggle
        self.button = button
        button.setTitle("?", for: .normal)
        self.swit = swit
        toggle.addTarget(self, action: #selector(MyController.onToggleTouch(toggleButton:)), for: .touchDown)
        button.addTarget(self, action: #selector(MyController.onButtonTouch(button:)), for: .touchDown)
         swit.addTarget(self, action: #selector(MyController.onSwitValueChange(swit:)), for: .valueChanged)
    }
    
    // MARK: User interactions
    
    @objc func onToggleTouch(toggleButton: ToggleButton) {
        self.isOn = toggleButton.isOn
    }
    @objc func onButtonTouch(button: UIButton) {
        button.isSelected = !button.isSelected
        self.isOn = button.isSelected
    }
    @objc func onSwitValueChange(swit: UISwitch) {
        self.isOn = swit.isOn
    }
    
    private func updateStates() {
        toggle.isOn = self.isOn
        swit.setOn(self.isOn, animated: true)
        let buttonTitle = isOn ? "!" : "?"
        button.setTitle(buttonTitle, for: .normal)
    }
}

//MARK: Main
let smiley = ToggleButton(onText: "😎", offText: "😶")
let button = UIButton()
let swit = UISwitch()

let stackView = CenterBlock()
stackView.layout(subviews: [smiley, button, swit], superview: containerView)

let controller = MyController(toggle: smiley, button: button, swit: swit)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
