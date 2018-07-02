//
//  EventTableViewCell.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    private struct Consts {
        static let dateFormat = "dd-MM-yyyy HH:mm"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setup(with event: EventModel) {
        titleLabel.text = event.name
        descriptionLabel.text = event.description
        let start = DateUtils.toString(date: event.start, format: Consts.dateFormat)
        let end = DateUtils.toString(date: event.end, format: Consts.dateFormat)
        timeLabel.text = start + " — " + end
    }
}
