//
//  TabBarButton.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/22/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import PinLayout
import ReactiveSwift

class TabBarButton: UIControl {
    
    var badge: String? {
        didSet {
            badgeView.value = badge
            setNeedsLayout()
        }
    }
    
    private lazy var badgeView: Badge = {
        let badge = Badge()
        badge.minHeight = 18
        addSubview(badge)
        setNeedsLayout()
        return badge
    }()
    
    @IBInspectable var topInset: CGFloat = 7 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var space: CGFloat = 2 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            setNeedsLayout()
        }
    }
    
    @IBInspectable var localizedText: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue?.localized
            setNeedsLayout()
        }
    }
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            setNeedsLayout()
        }
    }
    
    @IBInspectable var adjustBackgroundColor: Bool = false
    
    override var tintColor: UIColor! {
        didSet {
            updateColor()
        }
    }
    
    private(set) var imageView: UIImageView!
    private(set) var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.pin.hCenter().top(topInset)
        label.pin.below(of: imageView).marginTop(space).left().right()
        if badge != nil {
            badgeView.pin.topRight(to: imageView.anchor.topRight).marginTop(-6).marginRight(-8)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        label.sizeToFit()
        imageView.sizeToFit()
        let size = CGSize(width: max(label.bounds.size.width, imageView.bounds.size.width), height: imageView.bounds.size.height + space + label.bounds.size.height + topInset)
        return size
    }
    
    override func sizeToFit() {
        frame.size = intrinsicContentSize
    }
    
    override var isHighlighted: Bool {
        didSet {
            let alpha: CGFloat = isHighlighted ? 0.5 : 1
            imageView.alpha = alpha
            label.alpha = alpha
            if badge != nil {
                badgeView.alpha = alpha
            }
            if adjustBackgroundColor {
                backgroundColor = isHighlighted ? Colors.buttonSelected.uiColor : Colors.buttonNormal.uiColor
            }
        }
    }
    
}

private extension TabBarButton {
    
    func updateColor() {
        label.textColor = tintColor
        imageView.tintColor = tintColor
    }
    
    func setup() {
        imageView = UIImageView(frame: .zero)
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.tintColor = Colors.tabBarIconNormal.uiColor
        addSubview(imageView)
        
        label = UILabel(frame: .zero)
        label.textColor = Colors.tabBarIconNormal.uiColor
        label.font = Fonts.tabBarButton.uiFont
        label.textAlignment = .center
        addSubview(label)
        
        imageView.tintColor = tintColor
        label.textColor = tintColor
    }
    
}