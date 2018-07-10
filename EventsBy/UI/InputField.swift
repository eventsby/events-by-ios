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
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get {
            return inputField?.autocapitalizationType ?? .sentences
        }
        set {
            inputField?.autocapitalizationType = newValue
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
        static let height: CGFloat = 66
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
            separator?.backgroundColor = Colors.inputFieldSeparator.uiColor
            errorLabel?.text = nil
        } else {
            separator?.backgroundColor = Colors.inputFieldError.uiColor
            errorLabel?.text = error
        }
    }
    
}

private extension InputField {
    
    func setupView() {
        let inputField = UITextField(frame: .zero)
        self.inputField = inputField
        inputField.delegate = delegate
        inputField.textColor = Colors.inputFieldText.uiColor
        inputField.font = Fonts.inputFieldText.uiFont
        
        let tipLabel = UILabel(frame: .zero)
        self.tipLabel = tipLabel
        tipLabel.textColor = Colors.inputFieldTip.uiColor
        tipLabel.font = Fonts.inputFieldTip.uiFont
        
        let separator = UIView(frame: .zero)
        self.separator = separator
        separator.backgroundColor = Colors.inputFieldSeparator.uiColor
        
        let errorLabel = UILabel(frame: .zero)
        self.errorLabel = errorLabel
        errorLabel.textColor = Colors.inputFieldError.uiColor
        errorLabel.font = Fonts.inputFieldError.uiFont
        
        addSubview(tipLabel)
        addSubview(inputField)
        addSubview(separator)
        addSubview(errorLabel)
        
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
