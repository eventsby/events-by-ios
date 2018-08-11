//
//  InputField.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/10/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

final class InputField: UIView {
    
    @IBInspectable var localizedTip: String? {
        get {
            return tipLabel?.text
        }
        set {
            tipLabel?.text = newValue?.localized
        }
    }
    
    @IBInspectable override var tintColor: UIColor? {
        get {
            return inputField?.tintColor
        }
        set {
            inputField?.tintColor = newValue
        }
    }
    
    var text: String? {
        get {
            return inputField?.text
        }
        set {
            inputField?.text = newValue
            inputField?.sendActions(for: .allEditingEvents)
        }
    }
    
    var accessoryView: UIView? {
        get {
            return inputField?.inputAccessoryView
        }
        set {
            inputField?.inputAccessoryView = newValue
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            return inputField?.keyboardType ?? .default
        }
        set {
            inputField?.keyboardType = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType {
        get {
            return inputField?.returnKeyType ?? .default
        }
        set {
            inputField?.returnKeyType = newValue
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get {
            return inputField?.autocapitalizationType ?? .sentences
        }
        set {
            inputField?.autocapitalizationType = newValue
        }
    }
    
    var autocorrectionType: UITextAutocorrectionType {
        get {
            return inputField?.autocorrectionType ?? .default
        }
        set {
            inputField?.autocorrectionType = newValue
        }
    }
    
    var textContentType: UITextContentType? {
        get {
            return inputField?.textContentType
        }
        set {
            inputField?.textContentType = newValue
        }
    }
    
    var isSecureTextEntry: Bool {
        get {
            return inputField?.isSecureTextEntry ?? false
        }
        set {
            inputField?.isSecureTextEntry = newValue
        }
    }
    
    var delegate: UITextFieldDelegate? {
        get {
            return inputField?.delegate
        }
        set {
            inputField?.delegate = newValue
        }
    }
    
    private struct Consts {
        static let height: CGFloat = 60
        static let separatorHeight: CGFloat = 1
        static let errorLabelHeight: CGFloat = 16
    }
    
    private var tipLabel: UILabel?
    private var errorLabel: UILabel?
    private var separator: UIView?
    private(set) var inputField: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: Consts.height)
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        inputField?.becomeFirstResponder()
        return true
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        inputField?.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    func setValid(_ valid: Bool, error: String?) {
        if valid {
            separator?.backgroundColor = Asset.Colors.Main.inputFieldSeparator.color
            errorLabel?.text = nil
        } else {
            separator?.backgroundColor = Asset.Colors.Main.inputFieldError.color
            errorLabel?.text = error
        }
    }
    
}

private extension InputField {
    
    func addInputField() -> UITextField {
        let inputField = UITextField(frame: .zero)
        self.inputField = inputField
        inputField.delegate = delegate
        inputField.textColor = Asset.Colors.Main.inputFieldTextNormal.color
        inputField.font = Fonts.inputFieldText.uiFont
        addSubview(inputField)
        return inputField
    }
    
    func addTipLabel() -> UILabel {
        let tipLabel = UILabel(frame: .zero)
        self.tipLabel = tipLabel
        tipLabel.textColor = Asset.Colors.Main.inputFieldTip.color
        tipLabel.font = Fonts.inputFieldTip.uiFont
        addSubview(tipLabel)
        return tipLabel
    }
    
    func addSeparatorView() -> UIView {
        let separator = UIView(frame: .zero)
        self.separator = separator
        separator.backgroundColor = Asset.Colors.Main.inputFieldSeparator.color
        addSubview(separator)
        return separator
    }
    
    func addErrorLabel() -> UIView {
        let errorLabel = UILabel(frame: .zero)
        self.errorLabel = errorLabel
        errorLabel.textColor = Asset.Colors.Main.inputFieldError.color
        errorLabel.font = Fonts.inputFieldError.uiFont
        addSubview(errorLabel)
        return errorLabel
    }
    
    func setupView() {
        let inputField = addInputField()
        let tipLabel = addTipLabel()
        let separator = addSeparatorView()
        let errorLabel = addErrorLabel()
        
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        inputField.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
            tipLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipLabel.topAnchor.constraint(equalTo: topAnchor),
            tipLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputField.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: 13),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 5),
            separator.heightAnchor.constraint(equalToConstant: Consts.separatorHeight),
            
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 2),
            errorLabel.heightAnchor.constraint(equalToConstant: Consts.errorLabelHeight)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction() {
        inputField?.becomeFirstResponder()
    }
    
}

extension Reactive where Base: InputField {
    
    var text: BindingTarget<String?> {
        return makeBindingTarget { field, text in
            field.text = text
        }
    }
    
    var textValues: Signal<String?, NoError> {
        guard let field = base.inputField else {
            return .empty
        }
        return field.reactive.textValues
    }
    
    var continuousTextValues: Signal<String?, NoError> {
        guard let field = base.inputField else {
            return .empty
        }
        return field.reactive.continuousTextValues
    }
    
}
