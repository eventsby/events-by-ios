//
//  EventsViewController.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventListView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: EventListPresenterProtocol?
    
    private struct Consts {
        static let cellHeight: CGFloat = 170
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = Colors.pullToRefreshControl.uiColor
        return refreshControl
    }()
    
    // MARK: Lifecycle
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let itemSize = CGSize(width: collectionView.bounds.size.width, height: Consts.cellHeight)
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = itemSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: Actions
    
    @objc private func handlePullToRefresh() {
        presenter?.pullToRefresh()
    }

}

extension EventListView: EventListViewProtocol {
    
    func setupView() {
        collectionView.contentInset.top = 10.0
        collectionView.contentInset.bottom = 10.0
        navigationItem.title = "title_event_list".localized
        navigationItem.backBarButtonTitle = ""
        
        self.addMenuBarButton { [weak self] in
            guard let strongSelf = self else { return }
            Swift.print("[Action-TODO] Menu pressed")
        }
        
        collectionView.addSubview(self.refreshControl)
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func showEvents() {
        collectionView.reloadData()
    }
    
    func showError(_ error: Error?) {
        // TODO add check for 401 error, then show like "Session was expired. Please login"
        guard let errorStr = error?.localizedDescription else { return }
        MessangerService.showError(str: errorStr)
    }
    
    func showLoading() {
        HUDProgressService.show()
    }
    
    func hideLoading() {
        HUDProgressService.dismiss()
        refreshControl.endRefreshing()
    }
    
}
