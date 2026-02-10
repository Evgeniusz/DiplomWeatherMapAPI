//
//  Presenter.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 4.02.26.
//

import UIKit
import Foundation
protocol IPresenter {
    func cityRequest()
}

final class Presenter: IPresenter {
    let network: iNetworkService = NetworkService()
    
    var view: IView?
    
    func cityRequest() {
        network.cityRequest { [weak self] data in
            self?.view?.updateView(data: data)
            self?.windDirectionRadians(direction: data.current?.windDegrees ?? 0)
        }
    }
    
    func windDirectionRadians(direction: Int) {
        let radians = CGFloat(direction) * .pi / 180
        view?.updateWindDirection(radiance: radians)
    }
}
