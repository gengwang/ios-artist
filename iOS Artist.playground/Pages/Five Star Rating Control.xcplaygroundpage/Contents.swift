/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Custom Control: Five-Star Rating
 
 Another situation when we need a custom control is to compose multiple controls, in which case the custom control acts as the View Controller and is normally responsible for arranging its subviews and translating user interactions into changes in view states. 
 
 */

//MARK: Set up playground

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 300))

containerView.backgroundColor = UIColor.purple
PlaygroundPage.current.liveView = containerView

//MARK: Custom view

class RatingControl: UIStackView{
    
    static let DEFAULT_ICON_FONT_SIZE: CGFloat = 32
    static let DEFAULT_ICON_SIZE: CGFloat = 44
    static let DEFAULT_ICON_MARGIN: CGFloat = 1
    static let DEFAULT_ICON_FONT_NAME: String = "AppleColorEmoji"
    static let DEFAULT_NORMAL_ICON_CHARACTER: String = "😶"
    static let DEFAULT_SELECTED_ICON_CHARACTER: String = "😎"
    static let DEFAULT_HIGHLIGHTED_ICON_CHARACTER: String = "🤔"
    static let DEFAULT_RATING: Int = 0
    static let DEFAULT_MAX_RATINGS: Int = 5
    
    var rating: Int = RatingControl.DEFAULT_RATING {
        didSet {
            if rating < 0 {
                rating = 0
            }
            if rating > maxRatings {
                maxRatings = rating
            }
            layout()
        }
    }
    var maxRatings: Int = RatingControl.DEFAULT_MAX_RATINGS {
        didSet {
            if maxRatings == 0 {
                maxRatings = 1
            }
            if rating > maxRatings {
                maxRatings = rating
            }
            layout()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
//    convenience init() {
//        self.init(frame: CGRect.zero)
//        setup()
//    }

    private var ratingButtons = [UIButton]()
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fillEqually
        rating = RatingControl.DEFAULT_RATING
        spacing = RatingControl.DEFAULT_ICON_MARGIN
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: CGFloat(maxRatings) * RatingControl.DEFAULT_ICON_SIZE, height: RatingControl.DEFAULT_ICON_SIZE)
    }
    
    @objc func onTouch(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button: \(button) is not in the rating buttons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        // Reset the rating to zero if the current rating button is tapped
        if selectedRating == rating {
            rating = 0
        }else {
            rating = index + 1
        }
        
    }
    private func layout() {
        for button in ratingButtons {
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        self.widthAnchor.constraint(equalToConstant: RatingControl.DEFAULT_ICON_SIZE * CGFloat(maxRatings))
        
        for index in 0..<maxRatings {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: RatingControl.DEFAULT_ICON_SIZE, height: RatingControl.DEFAULT_ICON_SIZE))
            button.titleLabel?.font = UIFont(name: RatingControl.DEFAULT_ICON_FONT_NAME, size: RatingControl.DEFAULT_ICON_FONT_SIZE)
            button.setTitle(RatingControl.DEFAULT_NORMAL_ICON_CHARACTER, for: .normal)
            button.setTitle(RatingControl.DEFAULT_SELECTED_ICON_CHARACTER, for: .selected)
            button.setTitle(RatingControl.DEFAULT_HIGHLIGHTED_ICON_CHARACTER, for: .highlighted)
            button.isSelected = index < rating
            
            button.addTarget(self, action: #selector(RatingControl.onTouch(button:)), for: .touchUpInside)

            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}

//MARK: Main

let rating = RatingControl()
rating.rating = 6
rating.maxRatings = 10
containerView.addSubview(rating)

// Center rating view
let centerX = NSLayoutConstraint(item: rating, attribute: .centerX, relatedBy: .equal, toItem: rating.superview, attribute: .centerX, multiplier: 1.0, constant: 0)

let centerY = NSLayoutConstraint(item: rating, attribute: .centerY, relatedBy: .equal, toItem: rating.superview, attribute: .centerY, multiplier: 1.0, constant: 0)

NSLayoutConstraint.activate([centerX, centerY])

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
