/*:
 # iOS UI Fundamentals: Trivial MVC in Playground
 
 **Supported versions:**
 - Swift 3.0.1
 - XCode Version 8.1 (8B62)
 
 The *live view* (i.e. `Timeline`) can be enabled by selecting `View > Assistant Editor > Show Assistant Editor`. then select `Timeline` in `Assistant Editor` if it's not already selected.
 */

// TODO: Model should be updated while the text is being edited, instead of after Return key is pressed (the last character changed is not carried over)
// TODO: AutoSizing layout instead of stack layout
// TODO: Animation for text transition in text field and label
// TODO: Animation for button transition
// TODO: Explores a different user interaction: Pulse animate button > User click on button > Sync text in text field and label > Text field clears text and becomes first responder > Transition in placeholder as a question mark > Transition in label as a container glyph. Shake animate button when text field input is an empty string

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

// MARK: Main

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





