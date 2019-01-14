//
//  PaginationQuery.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 1/15/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

protocol PaginationQueryType {
    var offset: Int { get }
    var limit: Int { get }
}

struct PaginationQuery: PaginationQueryType {
    
    let offset: Int
    let limit: Int
    
}
