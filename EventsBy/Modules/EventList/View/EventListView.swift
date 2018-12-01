//
//  EventsViewController.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventListView: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: EventListPresenterProtocol?
    
    private struct Consts {
        static let cellHeight: CGFloat = 170
        static let collectionTopInset: CGFloat = 10
        static let collectionBottomInset: CGFloat = 10
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        refreshControl.tintColor = Asset.Colors.Main.pullToRefresh.color
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
        collectionView.contentInset.top = Consts.collectionTopInset
        collectionView.contentInset.bottom = Consts.collectionBottomInset
        navigationItem.title = L10n.EventList.title
        navigationItem.backBarButtonTitle = ""
        
        self.addMenuBarButton { [weak self] in
            guard let strongSelf = self else { return }
            LoggerService.log.debug("Menu pressed: \(strongSelf)")
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
        guard let errorStr = error?.localizedDescription else { return }
        showAlert(title: "", message: errorStr)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }
    
}
