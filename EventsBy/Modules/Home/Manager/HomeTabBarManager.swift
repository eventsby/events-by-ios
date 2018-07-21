//
//  HomeTabBarManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/20/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import UIKit

protocol HomeManagerInputProtocol: class {
    var handler: HomeManagerOutputProtocol? { get set }
    var items: [TabBarItemProtocol] { get set }
    var selectedIndex: Int { get set }
    var defaultTab: Int { get set }
    
    func initialize()
    func selectTab(index: Int)
    func setupButtons() -> [UIButton]
    func setupControllers() -> [UIViewController]
}

protocol HomeManagerOutputProtocol: class {
    func setupTabBar(_ items: [TabBarItemProtocol])
    func controllerSwitched(to: TabBarItemProtocol, from: TabBarItemProtocol)
}

class HomeTabBarManager: HomeManagerInputProtocol {
    
    var handler: HomeManagerOutputProtocol?
    
    internal var items: [TabBarItemProtocol] = []
    internal var selectedIndex: Int = 0
    internal var defaultTab: Int = 0
    
    func initialize() {
        let buttons = setupButtons()
        let controllers = setupControllers()
        guard buttons.count == controllers.count else { return }
        var items: [TabBarItemProtocol] = []
        
        for index in 0..<buttons.count {
            let vc = controllers[index]
            let button = buttons[index]
            let item: TabBarItemProtocol = HomeTabBarItem(item: vc, button: button)
            items.append(item)
        }
        
        self.items = items
        self.handler?.setupTabBar(items)
        self.selectTab(index: defaultTab)
    }
    
    func selectTab(index: Int) {
        guard index >= 0 && index < items.count else { return }
        let buttons = items.map({ $0.button })
        buttonAction(buttons[index])
    }
    
    func setupButtons() -> [UIButton] {
        let button1 = UIButton(type: .system)
        button1.tag = 0
        button1.setTitle("EVENTS", for: .normal)
        button1.setTitle("EVENTS", for: .selected)
        button1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        let button2 = UIButton(type: .system)
        button2.tag = 1
        button2.setTitle("LOGIN", for: .normal)
        button2.setTitle("LOGIN", for: .selected)
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return [button1, button2]
    }
    
    func setupControllers() -> [UIViewController] {
        let eventsVC = EventListRouter.initializeEventListModule()
        let loginVC = LoginRouter.initializeLoginModule()
        return [eventsVC, loginVC]
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        let buttons = items.map({ $0.button })
        let previousIndex = self.selectedIndex
        self.selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        buttons[previousIndex].tintColor = .red
        sender.isSelected = true
        sender.tintColor = .yellow
        
        let previousVC = items[previousIndex]
        let selectedVC = items[selectedIndex]
        handler?.controllerSwitched(to: selectedVC, from: previousVC)
    }
    
}
