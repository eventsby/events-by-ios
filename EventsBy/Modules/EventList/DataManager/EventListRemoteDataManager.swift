//
//  EventListRemoteDataManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol EventListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: EventListRemoteDataManagerOutputProtocol? { get set }
    
    // Interactor -> REMOTEDATAMANAGER
    func retrieveEventList()
}

protocol EventListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> Interactor
    func onEventListRetrieved(_ events: [EventModel])
    func onError()
}

class EventListRemoteDataManager: EventListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: EventListRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        Alamofire
            .request(Endpoints.Posts.fetch.url, method: .get)
            .validate()
            .responseArray(completionHandler: { (response: DataResponse<[PostModel]>) in
                switch response.result {
                case .success(let posts):
                    self.remoteRequestHandler?.onPostsRetrieved(posts)
                    
                case .failure( _):
                    self.remoteRequestHandler?.onError()
                }
            })
    }
    
}
