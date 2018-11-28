//
//  LoginView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class LoginView: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameInputField: InputField!
    @IBOutlet weak var passwordInputField: InputField!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    // MARK: Actions
    
    @IBAction func onLoginAction(_ sender: Any) {
        presenter?.loginAction()
    }
    
    @IBAction func onCloseAction(_ sender: Any) {
        presenter?.closeAction()
    }
    
}

extension LoginView: LoginViewProtocol {
    
    func setupView() {
        guard let presenter = self.presenter else { return }
        presenter.login <~ nameInputField.reactive.continuousTextValues
        presenter.password <~ passwordInputField.reactive.continuousTextValues
        loginButton.reactive.isEnabled <~ presenter.loginButtonEnabled
        
        nameInputField.returnKeyType = .next
        nameInputField.autocapitalizationType = .none
        nameInputField.autocorrectionType = .no
        nameInputField.textContentType = .username
        passwordInputField.returnKeyType = .done
        passwordInputField.autocapitalizationType = .none
        passwordInputField.autocorrectionType = .no
        passwordInputField.textContentType = .password
        passwordInputField.isSecureTextEntry = true
        
        closeButton.isHidden = presenter.isModal
    }
    
    func onClose(animated: Bool) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSuccessLogin() {
        let successLoginMsg = L10n.Login.Message.success
        MessangerService.showSuccess(str: successLoginMsg)
    }
    
    func showLoading() {
        HUDProgressService.show(view: self.view)
    }
    
    func hideLoading() {
        HUDProgressService.dismiss()
    }
    
    func showError(_ error: Error?) {
        guard let errorStr = error?.localizedDescription else { return }
        MessangerService.showError(str: errorStr)
    }
    
    func showInvalidCredentialsError() {
        let invalidCredentialsMsg = L10n.Login.Message.invalidCredentials
        MessangerService.showWarning(str: invalidCredentialsMsg)
    }
    
}
