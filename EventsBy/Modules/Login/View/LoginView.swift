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
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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
        
        nameInputField.returnKeyType = .next
        nameInputField.autocapitalizationType = .none
        passwordInputField.returnKeyType = .done
        passwordInputField.autocapitalizationType = .none
        
        closeButton.isHidden = presenter.isModal
    }
    
    func onClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSuccessLogin() {
        let successLoginMsg = "login_success".localized
        MessangerService.showSuccess(str: successLoginMsg)
    }
    
    func showLoading() {
        HUDProgressService.show()
    }
    
    func hideLoading() {
        HUDProgressService.dismiss()
    }
    
    func showError(_ error: Error?) {
        guard let errorStr = error?.localizedDescription else { return }
        MessangerService.showError(str: errorStr)
    }
    
    func showInvalidCredentialsError() {
        let invalidCredentialsMsg = "login_invalid_credentials".localized
        MessangerService.showWarning(str: invalidCredentialsMsg)
    }
    
}
