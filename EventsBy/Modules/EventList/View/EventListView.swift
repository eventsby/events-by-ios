//
//  EventsViewController.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import PKHUD

class EventListView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: EventListPresenterProtocol?
    var eventList: [EventModel] = []
    
    private struct Consts {
        static let cellHeight: CGFloat = 170
    }
    
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

}

extension EventListView: EventListViewProtocol {
    
    func setupView() {
        collectionView.contentInset.top = 10.0
        collectionView.contentInset.bottom = 10.0
    }
    
    func showEvents(_ events: [EventModel]) {
        eventList = events
        collectionView.reloadData()
    }
    
    func showError(_ error: Error?) {
        guard let errorStr = error?.localizedDescription else { return }
        HUD.flash(.label(errorStr), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}

extension EventListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventViewCell", for: indexPath) as? EventViewCell else {
            return UICollectionViewCell()
        }
        let item = eventList[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item >= eventList.count - 2 {
//            presenter?.loadMore()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showEventDetail(for: eventList[indexPath.row])
    }
    
}
