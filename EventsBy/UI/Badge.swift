//
//  Badge.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class Badge: UILabel {
    
    private struct Consts {
        static let verticalInsets: CGFloat = 3
    }
    
    @IBInspectable var fontSize: CGFloat = 16 {
        didSet {
            updateFont()
        }
    }
    @IBInspectable var fontName: String? {
        didSet {
            updateFont()
        }
    }
    @IBInspectable var value: String? {
        didSet {
            text = value
            isHidden = value == nil
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var minHeight: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var intrinsicContentSize: CGSize {
        sizeToFit()
        let height = max(bounds.size.height, minHeight)
        return CGSize(width: max(bounds.size.width + 2 * Consts.verticalInsets, height), height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = bounds.size.height / 2
        frame.size = intrinsicContentSize
    }
    
}

private extension Badge {
    
    func updateFont() {
        if let fontName = fontName {
            font = Fonts.custom(name: fontName, size: fontSize).uiFont
        } else {
            font = Fonts.button(size: fontSize).uiFont
        }
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Asset.Colors.Badge.badgeBackground.color
        textColor = Asset.Colors.Badge.badgeText.color
        font = Fonts.badgeText.uiFont
        textAlignment = .center
        clipsToBounds = true
        isHidden = value == nil
    }
    
}

extension Reactive where Base: Badge {
    
    var value: BindingTarget<String?> {
        return makeBindingTarget { target, value in
            target.value = value
        }
    }
    
}
