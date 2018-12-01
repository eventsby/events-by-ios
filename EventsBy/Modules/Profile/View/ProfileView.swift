//
//  ProfileView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var notAuthenticatedView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var presenter: ProfilePresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @IBAction func authenticateAction(_ sender: Any) {
        presenter?.authenticateAction()
    }
    
}

extension ProfileView: ProfileViewProtocol {
    
    func setupView() {
        self.navigationItem.title = L10n.Profile.title
    }
    
    func update(with status: UserStatus) {
        profileView.isHidden = status.isAnonymous
        notAuthenticatedView.isHidden = !status.isAnonymous
    }
    
    func onSuccessUserInfo(_ user: UserDetailProtocol) {
        fullNameLabel.text = user.fullname
    }
    
    func showLoading() {
        HUDProgressService.show(view: self.view)
    }
    
    func hideLoading() {
        HUDProgressService.dismiss()
    }
    
    func showError(_ error: Error?) {
        guard let errorStr = error?.localizedDescription else { return }
        showAlert(title: "", message: errorStr)
    }
    
}
