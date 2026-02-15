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
    func findCityRequest(city: String)
    func cityRequestFromTableViewByCoordinates(coordinates: Coordinates)
    func addObjectCityTiArray(object: CityNames)
}

final class Presenter: IPresenter {
    let network: iNetworkService = NetworkService()
    var arrayCities: [CityNames]=[]
    var view: IView?
    
    func cityRequest() {
        network.currentCityRequest { [weak self] data in
            self?.view?.updateView(data: data)
            self?.windDirectionRadians(direction: data.current?.windDegrees ?? 0)
        }
    }
    
    func windDirectionRadians(direction: Int) {
        let radians = CGFloat(direction) * .pi / 180
        view?.updateWindDirection(radiance: radians)
    }
    
    func addObjectCityTiArray(object: CityNames){
        arrayCities.append(object)
        DispatchQueue.main.async {
            self.view?.cityArraySearchBefore = self.arrayCities
            self.view?.tableViewCitySeenBefore.reloadData()
        }
    }
    
    func findCityRequest(city: String) {  //что передаем в vc
        network.cityRequest(text: city) { [weak self] city in
            DispatchQueue.main.async {
                self?.view?.cityArrayFromBack = city
                self?.view?.addTableView()
                self?.view?.tableViewSearch.reloadData()
            }
                                    // MABY HEREEEEE?)
        }
    }
    
    func cityRequestFromTableViewByCoordinates(coordinates: Coordinates){
        network.coordinatesCityRequest(coordinates: coordinates) { [weak self] data in
            self?.view?.updateView(data: data)
            self?.windDirectionRadians(direction: data.current?.windDegrees ?? 0)
        }
    }
    
}
