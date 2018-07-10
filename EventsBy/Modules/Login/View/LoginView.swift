//
//  LoginView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import PKHUD

class LoginView: UIViewController {
    
    
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: Actions
    
    @IBAction func onCloseAction(_ sender: Any) {
        presenter?.closeAction()
    }
    
}

extension LoginView: LoginViewProtocol {
    
    func setupView() {
        
    }
    
    func onClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSuccessLogin() {
        
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
