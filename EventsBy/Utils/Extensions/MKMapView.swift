//
//  MKMapView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    func setCenter(_ location: Location, animated: Bool) {
        self.setCenter(location.clLocation, animated: animated)
    }
    
    func setCenter(_ location: Location, delta: Double, animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let region = MKCoordinateRegion(center: location.clLocation, span: span)
        self.setRegion(region, animated: animated)
    }
    
}
