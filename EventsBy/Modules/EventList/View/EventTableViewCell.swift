//
//  EventTableViewCell.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with event: EventModel) {
        titleLabel.text = event.name
    }
}
