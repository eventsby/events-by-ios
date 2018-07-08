//
//  EventDetailPresenterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventDetailPresenterProtocol: class {
    var view: EventDetailViewProtocol? { get set }
    var router: EventDetailRouterProtocol? { get set }
    var event: EventModel? { get set }
    var participantsCount: Int { get }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showParticipantDetail(for participant: ParticipantModel)
    func participant(at index: Int) -> ParticipantModel?
    
    func websiteTapAction()
    func emailTapAction()
}
