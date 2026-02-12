//
//  Buttons.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 11.02.26.
//

import UIKit

final class Buttons: UIButton {
    var title: String
    var color: UIColor
    var lon: Double
    var lat: Double
    
    init(title: String, color: UIColor, lon: Double, lat: Double) {
        self.title = title
        self.color = color
        self.lon = lon
        self.lat = lat
        
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
