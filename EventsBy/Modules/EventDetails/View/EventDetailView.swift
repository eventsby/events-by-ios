//
//  EventDetailsViewController.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import MapKit

class EventDetailView: UIViewController {
    
    private struct Consts {
        static let dateFormat = "dd-MM-yyyy HH:mm"
        static let annotationIdentifier = "eventAnnotation"
        static let participantCell = "participantCell"
    }

    @IBOutlet weak var eventCityLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventAddressLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var participantsTableView: UITableView!
    
    @IBOutlet weak var organaizerDescription: UILabel!
    @IBOutlet weak var organaizerWebsiteLabel: UILabel!
    @IBOutlet weak var organaizerEmailLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    
    var presenter: EventDetailPresenterProtocol?
    
    let mapZoom = 0.02
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension EventDetailView: EventDetailViewProtocol {
    
    func setupView() {
        mapView.delegate = self
        mapView.register(EventMapAnnotationView.self, forAnnotationViewWithReuseIdentifier: Consts.annotationIdentifier)
        
        participantsLabel.text = String(format:
            "title_participants".localized, presenter?.event?.participants.count ?? 0)
    }
    
    func bindEventDetail(for event: EventModel) {
        // event
        eventCityLabel.text = event.location.city
        eventNameLabel.text = event.name
        eventDescriptionLabel.text = event.description
        let start = DateUtils.toString(date: event.start, format: Consts.dateFormat)
        let end = DateUtils.toString(date: event.end, format: Consts.dateFormat)
        eventTimeLabel.text = start + " - " + end
        eventAddressLabel.text = event.location.city + ", " + event.location.address
        
        // organaizer
        organaizerEmailLabel.text = event.organaizer.email
        organaizerWebsiteLabel.text = event.organaizer.website
        
        // map
        mapView.setCenter(event.location.location, delta: mapZoom, animated: false)
        let eventAnnotation = EventAnnotation(location: event.location.location, title: event.location.city, subtitle: event.location.address)
        mapView.addAnnotation(eventAnnotation)
        
        // title
        navigationItem.title = event.name
    }
    
}

extension EventDetailView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Consts.annotationIdentifier, for: annotation)
        return annotationView
    }
    
}

extension EventDetailView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.participants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Consts.participantCell, for: indexPath) as? ParticipantCell else {
            return UITableViewCell()
        }
        guard let participant = presenter?.participants[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setup(with: participant)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let participant = presenter?.participants[indexPath.row] else { return }
        presenter?.showParticipantDetail(for: participant)
    }
    
}
