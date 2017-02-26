import Foundation
import UIKit

/**
 Return a text layer object representing an Apple emoji glyph.
 */
public func emojiLayer(_ string: String) -> CATextLayer {
    let textLayer = CATextLayer()
    
    textLayer.bounds.size = CGSize(width: 44*1.6, height: 44*1.6)
    // Debug
    //    textLayer.borderWidth = 1
    
    textLayer.font = CTFontCreateWithName("AppleColorEmoji" as CFString?, 0.0, nil)
    textLayer.string = string
    textLayer.fontSize = 44
    // Center text
    textLayer.alignmentMode = kCAAlignmentCenter
    // Prevent blurriness
    textLayer.contentsScale = UIScreen.main.scale
    return textLayer
}
/**
 Return a shape layer object with a path specified with the points
 */
public func lineLayer(_ points: [CGPoint], color: UIColor = UIColor.black, lineWidth: CGFloat = 1.0)-> CAShapeLayer {
    let path = UIBezierPath()
    
    for (index, point) in points.enumerated() {
        if index == 0 {
            path.move(to: point)
        }else {
            path.addLine(to: point)
            if index == points.count - 1 {
                path.addLine(to: points.first!)
                path.close()
            }
        }
    }
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.lineDashPattern = [5.0, 6.0]
    return shapeLayer
}
/**
 The object draws grids inside itself.
 */
public class GridView: UIView {
    public var step: CGFloat = 100.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    public var gridColor: UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    public var lineWidth: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    override public func draw(_ rect: CGRect) {
        // clear context before we start drawing
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        
        UIColor.clear.setFill()
        
        let step = Int(self.step)
        let bound = max(self.bounds.width, self.bounds.height)
        
        for i in stride(from: 0, through: Int(bound), by: step) {
            // draw horizontal lines
            let xline = UIBezierPath()
            xline.lineWidth = lineWidth
            xline.move(to: CGPoint(x: 0, y: CGFloat(i)))
            xline.addLine(to: CGPoint(x: bound, y: CGFloat(i)))
            // draw vertical lines
            let yline = UIBezierPath()
            yline.lineWidth = lineWidth
            yline.move(to: CGPoint(x: CGFloat(i), y: 0))
            yline.addLine(to: CGPoint(x: CGFloat(i), y: bound))
            
            gridColor.setStroke()
            xline.stroke()
            yline.stroke()
        }
    }
    // Set background transparent
    private func setup() {
        self.isOpaque = false
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
/**
 This stack view centers the subviews relative to its superview; its subview is horizontally stacked.
 */
public class CenterBlock: UIStackView {
    public func layout(subviews: [UIView], superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.spacing = 12
        self.distribution = .fillEqually
        
        for subview in subviews {
            self.addArrangedSubview(subview)
        }
        
        superview.addSubview(self)
        
        let centerXConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYContstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([centerXConstraint, centerYContstraint])
    }
}

/**
 This control has two states, which is presented with two strings ("on" and "off").
 */
public class ToggleButton: UIControl {
    private var onLabel: UILabel!
    private var offLabel: UILabel!
    static let DEFAULT_ICON_Y_OFFSET: CGFloat = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    public convenience init(onText: String, offText: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        setText(on: onText, off: offText)
        self.sizeToFit()
        //        invalidateIntrinsicContentSize()
    }
    private func initialize() {
        //        self.backgroundColor = UIColor.blue
        self.addTarget(self, action: #selector(onTouch(target:)), for: .touchDown)
        setText(on: "On", off: "Off")
        self.isOn = false
    }
    private func setText(on:String, off:String) {
        self.onText = on
        self.offText = off
    }
    func onTouch(target:AnyObject) {
        self.isOn = !self.isOn
    }
    public var onText = "On" {
        didSet {
            if (onLabel != nil) && onLabel.superview === self {
                onLabel.text = onText
            }else {
                onLabel = UILabel()
                onLabel.text = onText
                onLabel.textColor = UIColor.gray
                self.addSubview(onLabel)
                // center the icon
                onLabel.translatesAutoresizingMaskIntoConstraints = false
                onLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
                let centerXConstraint = NSLayoutConstraint(item: onLabel, attribute: .centerX, relatedBy: .equal, toItem: onLabel.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
                let centerYConstraint = NSLayoutConstraint(item: onLabel, attribute: .centerY, relatedBy: .equal, toItem: onLabel.superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
                NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
            }
            onLabel.sizeToFit()
        }
    }
    override public var intrinsicContentSize: CGSize  {
        let width = max(onLabel.frame.width, offLabel.frame.width)
        let height = max(onLabel.frame.height, offLabel.frame.height)
        return CGSize(width: width, height: height)
    }
    public var offText = "Off" {
        didSet {
            if (offLabel != nil) && offLabel.superview === self {
                offLabel.text = offText
            } else {
                offLabel = UILabel()
                offLabel.text = offText
                offLabel.textColor = UIColor.gray
                self.addSubview(offLabel)
                
                // center the icon
                offLabel.translatesAutoresizingMaskIntoConstraints = false
                offLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
                let centerXConstraint = NSLayoutConstraint(item: offLabel, attribute: .centerX, relatedBy: .equal, toItem: offLabel.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
                let centerYConstraint = NSLayoutConstraint(item: offLabel, attribute: .centerY, relatedBy: .equal, toItem: offLabel.superview, attribute: .centerY, multiplier: 1.0, constant: 0)
                NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
            }
            offLabel.sizeToFit()
        }
    }
    private func updateLabelStates() {
        if isOn {
            self.offLabel.alpha = 0
            self.offLabel.frame.origin.y = self.offLabel.frame.origin.y + ToggleButton.DEFAULT_ICON_Y_OFFSET
            self.onLabel.alpha = 1
            self.onLabel.frame.origin.y = (self.bounds.height - self.onLabel.frame.height)/2
        }else {
            self.offLabel.alpha = 1
            self.offLabel.frame.origin.y = (self.bounds.height - self.offLabel.frame.height)/2
            self.onLabel.alpha = 0
            self.onLabel.frame.origin.y = self.onLabel.frame.origin.y + ToggleButton.DEFAULT_ICON_Y_OFFSET
        }
        
    }
    
    public var isOn:Bool = false {
        willSet {
            updateLabelStates()
        }
        didSet {
            UIView.animate(withDuration: 0.333, delay: 0.0, options: .transitionCurlUp, animations: {
                self.updateLabelStates()
            }, completion: nil)
        }
    }
}

/**
  Convenient methods for UIView
 */
public extension UIView {
    static func viewWith(backgroundColor: UIColor) -> UIView {
        let v = UIView(frame: .zero)
        v.backgroundColor = backgroundColor
//        v.layer.cornerRadius = 3
        v.layer.masksToBounds = true
        return v
    }
}
