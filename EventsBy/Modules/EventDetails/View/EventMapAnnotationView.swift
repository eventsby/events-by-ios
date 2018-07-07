//
//  EventMapAnnotationView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import MapKit

final class EventMapAnnotationView: MKAnnotationView {
    
    private lazy var calloutView: EventMapNoteView = {
        let view = EventMapNoteView.fromNib()
        view.isHidden = true
        self.addSubview(view)
        self.sendSubview(toBack: view)
        view.setFirstText(annotation?.title ?? "")
        view.setSecondText(annotation?.subtitle ?? "")
        let size = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        view.frame.size.width = size.width
        view.frame.origin.x = self.bounds.size.width - 10
        view.frame.origin.y = self.bounds.size.height / 2 - view.bounds.size.height / 2
        
        view.layer.shadowPath = CGPath(rect: view.bounds, transform: nil)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        
        return view
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = #imageLiteral(resourceName: "icn_location")
        self.canShowCallout = false
        
        DispatchQueue.main.async {
            self.isSelected = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        if view == nil && self.isSelected {
            let pointInCallout = self.convert(point, to: calloutView)
            view = calloutView.hitTest(pointInCallout, with: event)
        }
        return view
    }
    
    override var isSelected: Bool {
        didSet {
            calloutView.isHidden = isSelected == false
        }
    }
    
}
