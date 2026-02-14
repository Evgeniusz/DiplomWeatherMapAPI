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
}

final class Presenter: IPresenter {
    let network: iNetworkService = NetworkService()
    var array: [Buttons]=[]
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
    
    func addButtonArray(button: UIButton, coordinates: Coordinates) {
        guard let title = button.currentTitle else {return}
        let color = button.currentTitleColor
        let button = Buttons(title: title, color: color, lon: coordinates.lon, lat: coordinates.lat)
        array.append(button)
    }
    
    func createButton(){
        //идея тут берем из текстфилда текст, добавляем в запрос - сделать запрос по имени, и возвращаем парсенные названия
        //потом выбранные передаем в массив и обновляем тейбл вью
        //under cuurentGeo made tableView and only after - made text field to city finder
        //look for city by uipicker
    }
    
    func findCityRequest(city: String) {  //что передаем в vc
        network.cityRequest(text: city) { [weak self] city in
            self?.view?.cityArrayFromBack = city
        }
    }
    
    func cityRequestFromTableViewByCoordinates(coordinates: Coordinates){
        network.coordinatesCityRequest(coordinates: coordinates) { [weak self] data in
            self?.view?.updateView(data: data)
            self?.windDirectionRadians(direction: data.current?.windDegrees ?? 0)
        }
    }
    
}
