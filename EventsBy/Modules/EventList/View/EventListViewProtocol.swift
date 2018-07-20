//
//  File.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventListViewProtocol: class {
    var presenter: EventListPresenterProtocol? { get set }
    
    func showEvents()
    func showError(_ error: Error?)
    func showLoading()
    func hideLoading()
    
    func setupView()
    func reloadData()
}
