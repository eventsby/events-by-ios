//
//  MapInteractorProtocol.swift
//  EventsBy
//
//  Created by Anton Paliakov on 1/17/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit

protocol MapInteractorOutputProtocol: class {

}

protocol MapInteractorInputProtocol: class {
    var presenter: MapInteractorOutputProtocol? { get set }
    var service: MapServiceProtocol? { get set }
}
