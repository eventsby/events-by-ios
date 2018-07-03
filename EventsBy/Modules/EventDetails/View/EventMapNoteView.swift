//
//  EventMapNoteView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

final class EventMapNoteView: UIView {
    
    @IBOutlet private var firstTextLabel: UILabel!
    @IBOutlet private var secondTextLabel: UILabel!
    
    func setFirstText(_ text: String?) {
        firstTextLabel.text = text
    }
    
    func setSecondText(_ text: String?) {
        secondTextLabel.text = text
    }
    
}
