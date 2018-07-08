//
//  EventDetailRouterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventDetailRouterProtocol: class {
    static func createEventDetailModule(for event: EventModel) -> UIViewController
    
    func presentParticipantDetailScreen(from view: EventDetailViewProtocol, for participant: ParticipantModel)
    func openWebsite(url: String)
}
