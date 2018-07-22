//
//  ProfileView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
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
    
    func onSuccessUserInfo(_ user: UserDetailProtocol) {
        fullNameLabel.text = user.fullname
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
