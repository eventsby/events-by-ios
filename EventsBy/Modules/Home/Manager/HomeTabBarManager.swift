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
        var buttons: [UIButton] = []
        let button1 = UIButton(type: .system)
        button1.setImage(#imageLiteral(resourceName: "icn_event"), for: .normal)
        buttons.append(button1)
        let button2 = UIButton(type: .system)
        button2.setImage(#imageLiteral(resourceName: "icn_map"), for: .normal)
        buttons.append(button2)
        
        for index in 0..<buttons.count {
            buttons[index].tag = index
            buttons[index].addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            buttons[index].tintColor = Colors.tabBarIconNormal.uiColor
        }
        
        return buttons
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
        
        buttons[previousIndex].tintColor = Colors.tabBarIconNormal.uiColor
        sender.tintColor = Colors.tabBarIconSelected.uiColor
        
        let previousVC = items[previousIndex]
        let selectedVC = items[selectedIndex]
        handler?.controllerSwitched(to: selectedVC, from: previousVC)
    }
    
}
