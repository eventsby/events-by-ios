//
//  File.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/28/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension EventListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.eventsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventViewCell", for: indexPath) as? EventViewCell else {
            return UICollectionViewCell()
        }
        guard let event = presenter?.event(at: indexPath.row) else { return UICollectionViewCell() }
        cell.setup(with: event)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = presenter?.eventsCount else {
            return
        }
        if indexPath.item >= count - 1 {
            presenter?.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let event = presenter?.event(at: indexPath.row) else { return }
        presenter?.showEventDetail(for: event)
    }
    
}
