//
//  HomeView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/20/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class HomeView: UIViewController {
    
    var presenter: HomePresenterProtocol?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarStackView: UIStackView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}

extension HomeView: HomeViewProtocol {
    
    func setupView() {
        
    }
    
    func controllerSwitched(to: TabBarItemProtocol, from: TabBarItemProtocol) {
        from.item.willMove(toParentViewController: nil)
        from.item.view.removeFromSuperview()
        from.item.removeFromParentViewController()
        
        addChildViewController(to.item)
        to.item.view.frame = containerView.bounds
        to.item.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(to.item.view)
        to.item.didMove(toParentViewController: self)
    }
    
    func setup(_ items: [TabBarItemProtocol]) {
        let buttons = items.map({ $0.button })
        for button in buttons {
            tabBarStackView.addArrangedSubview(button)
        }
    }
    
}
