//
//  EventDetailPresenterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol EventDetailPresenterProtocol: class {
    var view: EventDetailViewProtocol? { get set }
    var router: EventDetailRouterProtocol? { get set }
    var event: MutableProperty<EventProtocol>? { get set }
    var participantsCount: Property<Int> { get }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showParticipantDetail(for participant: ParticipantModel)
    func participant(at index: Int) -> ParticipantModel?
    
    func websiteTapAction()
    func emailTapAction()
    func wantToParticipateAction()
    
    //func add(event: EventProtocol)
}
