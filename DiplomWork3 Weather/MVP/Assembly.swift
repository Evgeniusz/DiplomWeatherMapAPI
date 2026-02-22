//
//  Assembler.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 4.02.26.
//

import UIKit
import Foundation

final class Assembly {
    func assemply() -> UIViewController {
        let service = NetworkService()
        let saver = SaveLoadManager()
        let presenter = Presenter(network: service, saver: saver)
        let controller = ViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }
}
