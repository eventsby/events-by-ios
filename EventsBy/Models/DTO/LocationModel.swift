//
//  LocationModel.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol LocationProtocol {
    
    var id: Int { get }
    var country: String { get }
    var city: String { get }
    var address: String { get }
    var location: Location { get }
    
}

struct LocationModel: LocationProtocol, Uniq, Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case country
        case city
        case address
        case longitude
        case latitude
    }
    
    let id: Int
    let country: String
    let city: String
    let address: String
    let longitude: Double
    let latitude: Double
    
    var location: Location {
        return Location(lat: latitude, long: longitude)
    }
    
    var identifier: String {
        return "\(id)"
    }
    
}
