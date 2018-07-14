//
//  LoginView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import PKHUD
import ReactiveSwift
import Result

class LoginView: UIViewController {
    
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
    }
    
    func onClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSuccessLogin() {
        let successLoginMsg = "login_success".localized
        MessangerService.showSuccess(str: successLoginMsg)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showError(_ error: Error?) {
        
    }
    
    func showInvalidCredentialsError() {
        
    }
    
}
