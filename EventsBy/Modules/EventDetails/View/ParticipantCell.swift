//
//  ParticipantCell.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    func setup(with participant: ParticipantModel) {
        nameLabel.text = participant.fullname
        descriptionLabel.text = participant.email
    }
    
}
