//
//  ProfileView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {
    
    var presenter: ProfilePresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}

extension ProfileView: ProfileViewProtocol {
    
    func setupView() {
        self.navigationItem.title = "profile_title".localized
    }
    
    func onSuccessUserInfo() {
        
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
    
}
