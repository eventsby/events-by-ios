//
//  EventDetailsViewController.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventDetailView: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var presenter: EventDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension EventDetailView: EventDetailViewProtocol {
    
    func showEventDetail(for event: EventModel) {
        titleLabel?.text = event.name
    }
    
}
