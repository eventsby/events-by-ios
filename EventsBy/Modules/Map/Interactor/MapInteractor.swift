//
//  MapInteractor.swift
//  EventsBy
//
//  Created by Anton Paliakov on 1/17/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import Foundation

class MapInteractor: MapInteractorInputProtocol {
    weak var presenter: MapInteractorOutputProtocol?
    var service: MapServiceProtocol?
}
