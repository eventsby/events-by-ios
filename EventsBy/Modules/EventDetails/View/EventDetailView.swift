//
//  EventDetailsViewController.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import ReactiveSwift

class EventDetailView: UIViewController {
    
    private struct Consts {
        static let dateFormat = "dd-MM-yyyy HH:mm"
        static let dateOnlyTime = "HH:mm"
        static let annotationIdentifier = "eventAnnotation"
        static let participantCell = "participantCell"
    }

    @IBOutlet weak var participateButton: UIButton!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventCityLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventAddressLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var participantsTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageHeight = eventImageView.frame.height / 2
        let newOrigin = CGPoint(x: 0, y: -imageHeight)
        scrollView.contentOffset = newOrigin
        scrollView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        eventImageView.frame.size.height = imageHeight
        
        mapView.isScrollEnabled = false
    }
    
    // MARK: Actions
    
    @IBAction func websiteTapAction(_ sender: Any) {
        presenter?.websiteTapAction()
    }
    
    @IBAction func emailTapAction(_ sender: Any) {
        presenter?.emailTapAction()
    }
    
    @IBAction func wantToParticipateAction(_ sender: Any) {
        presenter?.wantToParticipateAction()
    }
    
}

extension EventDetailView: EventDetailViewProtocol {
    
    // Participant Removed
    
    func participantRemoved() {
        let participantRemovedMsg = L10n.EventDetails.Message.participantRemoved
        MessangerService.showWarning(str: participantRemovedMsg)
    }
    
    func userNotParticipating() {
        let notParticipating = L10n.EventDetails.Message.participantNotInEvent
        MessangerService.showWarning(str: notParticipating)
    }
    
    func showEventDetail(_ event: EventProtocol) {
        self.bindEventDetail(for: event)
    }
    
    func participantAdded() {
        let participantAddedMsg = L10n.EventDetails.Message.participantAdded
        MessangerService.showSuccess(str: participantAddedMsg)
    }
    
    func alreadyParticipate() {
        let alreadyParticipateMsg = L10n.EventDetails.Message.participantAlreadyExists
        MessangerService.showWarning(str: alreadyParticipateMsg)
    }
    
    func showError(_ error: Error?) {
        guard let errorStr = error?.localizedDescription else { return }
        MessangerService.showInfo(str: errorStr)
    }
    
    func showLoading(initial: Bool) {
        HUDProgressService.show(view: self.view)
        if initial {
            scrollView.isHidden = true
        }
    }
    
    func hideLoading() {
        HUDProgressService.dismiss()
        scrollView.isHidden = false
    }
    
    func setupView() {
        mapView.delegate = self
        mapView.register(EventMapAnnotationView.self, forAnnotationViewWithReuseIdentifier: Consts.annotationIdentifier)
    }
    
    func bindEventDetail(for event: EventProtocol) {
        // event
        eventCityLabel.text = event.location.city
        eventNameLabel.text = event.name
        eventDescriptionLabel.text = event.description
        let start = DateUtils.toString(date: event.start, format: Consts.dateFormat)
        let isSameDay = Calendar.current.isDate(event.start, inSameDayAs: event.end)
        let endDateFormat = isSameDay ? Consts.dateOnlyTime : Consts.dateFormat
        let end = DateUtils.toString(date: event.end, format: endDateFormat)
        eventTimeLabel.text = start + " - " + end
        eventAddressLabel.text = event.location.city + ", " + event.location.address
        if let eventImageUrl = event.image {
            eventImageView.kf.setImage(with: URL(string: eventImageUrl))
        }
        
        // organaizer
        organaizerEmailLabel.text = event.organaizer.email
        organaizerWebsiteLabel.text = event.organaizer.website
        
        // map
        mapView.setCenter(event.location.location, delta: mapZoom, animated: false)
        let eventAnnotation = EventAnnotation(location: event.location.location, title: event.location.city, subtitle: event.location.address)
        mapView.addAnnotation(eventAnnotation)
        
        // title
        navigationItem.title = event.name
        
        // participants
        presenter?.participantsCount.producer.startWithValues {
            self.participantsLabel.text = L10n.EventDetails.Title.participants($0)
        }
        
        // TODO check user status after login (user can login, then status should be updated)
        presenter?.event?.producer.startWithValues {_ in
            guard let isParticipating = self.presenter?.isUserParticipating else { return }
            let participantButtonTitle = isParticipating.value ? L10n.EventDetails.Button.alreadyParticipate : L10n.EventDetails.Button.wantParticipate
            self.participateButton.setTitle(participantButtonTitle, for: .normal)
            self.participantsTableView.reloadData()
        }
    }
    
}

extension EventDetailView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Consts.annotationIdentifier, for: annotation)
        return annotationView
    }
    
}

extension EventDetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            eventImageView.frame.size.height = -offsetY
        } else {
            eventImageView.frame.size.height = eventImageView.frame.height
        }
    }
    
}

extension EventDetailView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.participantsCount.value ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Consts.participantCell, for: indexPath) as? ParticipantCell else {
            return UITableViewCell()
        }
        guard let participant = presenter?.participant(at: indexPath.row) else {
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
        guard let participant = presenter?.participant(at: indexPath.row) else { return }
        presenter?.showParticipantDetail(for: participant)
    }
    
}
