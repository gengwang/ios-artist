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

containerView.backgroundColor = UIColor.yellow

PlaygroundPage.current.liveView = containerView

// MARK: User interactions

class MyController: NSObject, UITextFieldDelegate {
    var name = "Water" {
        didSet{
            enableButton(name != oldValue)
        }
    }
    
    var textField: UITextField!
    var button: UIButton!
    var label: UILabel!
    
    func buttonClicked(_ sender: AnyObject) {
        if sender === button {
            updateUI()
        }
    }
    
    func enableButton(_ shouldEnable: Bool) {
        button.alpha = shouldEnable == true ? 1 : 0.2
        button.isEnabled = shouldEnable
    }
    
    func updateUI() {
        print("updateUI...")
        label.text = name
        enableButton(false)
        textField.becomeFirstResponder()
    }
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        print("textfield did begin ediding...")
    //    }
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        return true
    //    }
    //    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    //        return true
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            name = text
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("text is changing...", textField.text ?? "")
        if let text = textField.text {
            name = text
        }
        return true
    }
}

// MARK: Main app

let controller = MyController()

let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
textField.borderStyle = .line

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 32))

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
button.setTitle("☞", for: .normal)
button.backgroundColor = UIColor.darkGray
button.addTarget(controller, action: #selector(MyController.buttonClicked), for: .touchUpInside)

let vLayout = UIStackView(frame: CGRect(x: 20, y: 20, width: 300, height: 44))
vLayout.axis = .horizontal
vLayout.distribution = .fillEqually
vLayout.spacing = 12

vLayout.addArrangedSubview(textField)
vLayout.addArrangedSubview(button)
vLayout.addArrangedSubview(label)
containerView.addSubview(vLayout)

controller.label = label
controller.textField = textField
controller.textField.delegate = controller
controller.button = button

//controller.updateUI()

// Initialize UI
controller.textField.text = controller.name
controller.label.text = "Tea pot"

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
