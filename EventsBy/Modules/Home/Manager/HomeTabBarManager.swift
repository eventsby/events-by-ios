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
    func setupButtons() -> [UIControl]
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
    
    func setupButtons() -> [UIControl] {
        var buttons: [UIControl] = []
        let btn1 = TabBarButton(frame: .zero)
        btn1.image = #imageLiteral(resourceName: "icn_event")
        btn1.text = L10n.TabBar.events
        btn1.sizeToFit()
        buttons.append(btn1)
        let btn2 = TabBarButton(frame: .zero)
        btn2.image = #imageLiteral(resourceName: "icn_map")
        btn2.text = L10n.TabBar.map
        btn2.sizeToFit()
        buttons.append(btn2)
        let btn3 = TabBarButton(frame: .zero)
        btn3.image = #imageLiteral(resourceName: "icn_account_box")
        btn3.text = L10n.TabBar.profile
        btn3.sizeToFit()
        buttons.append(btn3)
        
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
        let profileVC = ProfileRouter.initializeProfileModule()
        return [eventsVC, loginVC, profileVC]
    }
    
    @objc private func buttonAction(_ sender: UIControl) {
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
