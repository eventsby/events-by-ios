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
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EventListPresenterProtocol?
    var eventList: [EventModel] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

}

extension EventListView: EventListViewProtocol {
    
    func showEvents(_ events: [EventModel]) {
        eventList = events
        tableView.reloadData()
    }
    
    func showError() {
        let error = "Error"
        HUD.flash(.label(error), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}

extension EventListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        let event = eventList[indexPath.row]
        cell.setup(with: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        presenter?.showEventDetail(for: eventList[indexPath.row])
    }
    
}
