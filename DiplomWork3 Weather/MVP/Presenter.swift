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
    func cityRequestFromTableViewByCoordinatesAndName(coordinates: Coordinates, name: String)
    func addObjectCityTiArray(object: CityNames)
    func loadData()
}

final class Presenter: IPresenter {
    let network: iNetworkService = NetworkService()
    var arrayCities: [CityNames]=[]
    var view: IView?
    let saver = SaveLoadManager()
    
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
        saver.saveArrayCity(arrayCities)
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
    //MARK: HERE NEED TO CHECK
    func cityRequestFromTableViewByCoordinates(coordinates: Coordinates){
        network.coordinatesCityRequest(coordinates: coordinates) { [weak self] data in
            self?.view?.updateView(data: data)
            self?.windDirectionRadians(direction: data.current?.windDegrees ?? 0)
        }
    }
    
    func cityRequestFromTableViewByCoordinatesAndName(coordinates: Coordinates, name: String){
        network.coordinatesCityRequest(coordinates: coordinates) { [weak self] data in
            self?.view?.updateViewCoordinates(data: data, name: name)
            self?.windDirectionRadians(direction: data.current?.windDegrees ?? 0)
        }
    }
    
    func loadData(){
        if arrayCities.isEmpty == true {
            guard let array = saver.loadArrayCity() else {return}
            arrayCities = array
            view?.cityArraySearchBefore = arrayCities
            view?.tableViewCitySeenBefore.reloadData()
        }
    }
    
}
