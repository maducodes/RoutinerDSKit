import Foundation
import UIKit

public class Button: UIView {
    let showIcon: Bool
    let buttonIcon: UIImage?
    let buttonIconTint: UIColor?
    let weigth: ButtonWeigth
    let type: ButtonType
    let isEnabled: Bool
    let buttonTitle: String
    let buttonAccessibilityLabel: String
    let buttonAccessibilityHint: String
    let buttonAccessibilityValue: String
    
    lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    public init(frame: CGRect,
                showIcon: Bool = false,
                buttonIcon: UIImage?,
                buttonIconTint: UIColor?,
                weigth: ButtonWeigth,
                type: ButtonType,
                isEnabled: Bool = true,
                buttonTitle: String,
                buttonAccessibilityLabel: String,
                buttonAccessibilityHint: String,
                buttonAccessibilityValue: String) {
        self.showIcon = showIcon
        self.buttonIcon = buttonIcon
        self.buttonIconTint = buttonIconTint
        self.weigth = weigth
        self.type = type
        self.isEnabled = isEnabled
        self.buttonTitle = buttonTitle
        self.buttonAccessibilityLabel = buttonAccessibilityLabel
        self.buttonAccessibilityHint = buttonAccessibilityHint
        self.buttonAccessibilityValue = buttonAccessibilityValue
        super.init(frame: frame)
        
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        button.setTitle(buttonTitle, for: .normal)
        button.isEnabled = isEnabled
        
        if showIcon {
            guard let tintColor = buttonIconTint else { return }
            let image = buttonIcon?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
            button.setImage(image, for: .normal)
        }
        
        buildLayoutColors()
        buildAccessibility()
        buildViewHierarchy()
        buildConstraints()
    }
    
    private func buildLayoutColors() {
        switch type {
        case .primary:
            button.setTitleColor(Colors.Primary.Base.white, for: .normal)
            button.setTitleColor(Colors.Primary.Black.black40, for: .highlighted)
            button.backgroundColor = Colors.Primary.Blue.blue100
            break
        case .secondary:
            button.setTitleColor(Colors.Primary.Black.black100, for: .normal)
            button.setTitleColor(Colors.Primary.Black.black40, for: .highlighted)
            button.backgroundColor = Colors.Primary.Base.white
            break
        case .outline:
            button.setTitleColor(Colors.Primary.Base.white, for: .normal)
            button.setTitleColor(Colors.Primary.Black.black40, for: .highlighted)
            button.backgroundColor = Colors.Primary.Base.white
            
            button.layer.borderColor = Colors.Primary.Black.black10?.cgColor
            button.layer.borderWidth = 1
            break
        }
    }
    
    private func buildAccessibility() {
        button.isAccessibilityElement = true
        button.accessibilityTraits = .button
        button.accessibilityLabel = buttonAccessibilityLabel
        button.accessibilityHint = buttonAccessibilityHint
        button.accessibilityValue = buttonAccessibilityValue
    }
    
    private func buildViewHierarchy() {
        addSubview(button)
    }
    
    private func buildConstraints() {
        switch weigth {
        case .small:
            button.heightAnchor.constraint(equalToConstant: 20).isActive = true
            break
        case .medium:
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            break
        case .large:
            button.heightAnchor.constraint(equalToConstant: 52).isActive = true
            break
        }
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
