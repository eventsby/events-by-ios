//
//  EventListRemoteDataManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift
import Result

enum EventListServiceError: Error {
    case requestFailed(Error?)
    case badRequest(String)
    case invalidJson(Error?)
    case statusCodeInvalid
    case unknown
}

protocol EventListServiceProtocol {
    func getEvents(page: Int, limit: Int) -> SignalProducer<EventPageArrayProtocol, EventListServiceError>
}

final class EventListService: EventListServiceProtocol {
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func getEvents(page: Int = 0, limit: Int) -> SignalProducer<EventPageArrayProtocol, EventListServiceError> {
        let endpoint = EventEndpoint.events(page: page, limit: limit)
        
        return SignalProducer { [weak self] observer, _ in
            guard let strongSelf = self else {
                observer.sendInterrupted()
                return
            }
            strongSelf.sessionManager
                .request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<401)
                .responseJSON { response in
                    if response.result.error == nil, let data = response.data {
                        guard let data = try? JSONDecoder().decode(EventPageArray.self, from: data) else {
                            observer.send(error: .invalidJson(nil))
                            observer.sendCompleted()
                            return
                        }
                        observer.send(value: data)
                        observer.sendCompleted()
                    } else {
                        observer.send(error: .requestFailed(response.result.error))
                        observer.sendCompleted()
                    }
            }
        }
    }
    
}
