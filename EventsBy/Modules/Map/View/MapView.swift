//
//  MapView.swift
//  EventsBy
//
//  Created by Anton Paliakov on 1/17/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit

class MapView: UIViewController {

    var presenter: MapPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MapView: MapViewProtocol {

    
}
