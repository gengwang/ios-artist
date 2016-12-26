/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Custom Control: Smiley Face Button
 
 One situation when we need a custom control is to simply customize certain aspects of a stock UIKit control. In this example, we create a button that displays the mundane smiley faces 😀 and acts like a checkbox.
 */


//MARK: Set up for UI in Playground

import Foundation
import UIKit
import PlaygroundSupport

let IconSize:Int = 44
let IconMargin:Int = 4
var NumOfIconsPerRow = 6
var NumOfIconsPerColumn = 6

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: (IconSize + IconMargin) * NumOfIconsPerRow, height: (IconSize + IconMargin) * NumOfIconsPerColumn))

containerView.backgroundColor = UIColor.black

PlaygroundPage.current.liveView = containerView

//MARK: View model

struct MyViewModel {
    
    struct MyViewCellModel {
        var x:Int = 0
        var y:Int = 0
        var selected:Bool = false
    }
    
    static func getModel()->[MyViewCellModel] {
        
        var result = Array(repeating: MyViewCellModel(), count: NumOfIconsPerColumn * NumOfIconsPerRow)
        
        result = result.enumerated().map({
            (i:Int, d:MyViewCellModel) -> MyViewCellModel in
            let randomNum:UInt32 = arc4random_uniform(100)
            let selected = randomNum > 75
            let x = (IconSize + IconMargin) * (i % NumOfIconsPerRow)
            let y = floor(Double((IconSize + IconMargin) * (i / NumOfIconsPerRow)))
            return MyViewCellModel(x: x, y: Int(y), selected: selected)
        })
        return result
    }
}

//MARK: Custom button

class FaceButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        setup()
    //    }
    
    func setup() {
        self.setTitle("😶", for: .normal)
        self.setTitle("🤔", for: .highlighted)
        self.setTitle("😎", for: .selected)
        self.addTarget(self, action: #selector(FaceButton.onTouch(sender:)), for: .touchUpInside)
    }
    // Add blue background when the button is selected
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor.blue
            }else{
                self.backgroundColor = UIColor.clear
            }
        }
    }
    // Emulate the behavior of a checkbox
    func onTouch(sender: UIButton) {
        if sender === self {
            isSelected = !isSelected
        }
    }
}

//MARK: Main

let model = MyViewModel.getModel()

for d in model {
    let button = FaceButton(frame: CGRect(x: d.x, y: d.y, width: IconSize, height: IconSize))
    button.isSelected = d.selected
    containerView.addSubview(button)
}

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
