//
//  ViewController.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 28.01.26.
//

import UIKit
import SnapKit
import CoreLocation
import Foundation

protocol IView {
    func updateView(data: MainParsing)
    func updateWindDirection(radiance: CGFloat)
}

class ViewController: UIViewController, CLLocationManagerDelegate, IView {
//    let network: iNetworkService = NetworkService()
    let locationManager = LocationManager.shared
    private let presenter: IPresenter
    
    let bigOffset: CGFloat = 50
    let standartOffset: CGFloat = 16
    var windSpeed: Double = 4.01
    
    private let generalView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private let viewForImageTempCity: UIView = {
        let view = UIView()
        return view
    }()
    
    private let viewForWindDirectionFells: UIView = {
        let view = UIView()
        return view
    }()
    
    private let labelCity: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Minsk"
        return label
    }()
    
    private let imageWeather: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "09n")
        return image
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 120, weight: .bold)
        label.text = "-16"
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .thin)
        label.text = "4.01 m/s"
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    private let windDirectionView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "compass")
        return view
    }()
    
    private let windDirection: UIImageView = {
        let view = UIImageView()
        view.image = .WD
        return view
    }()
    
    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        navigationController?.navigationBar.isHidden = true
        start()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        generalView.gradient()
    }
    
    
    func start(){
        presenter.cityRequest()
    }

    func addAllViews(){
        view.addSubview(generalView)
        generalView.addSubview(viewForImageTempCity)
        generalView.addSubview(viewForWindDirectionFells)
        viewForImageTempCity.addSubview(labelCity)
        viewForImageTempCity.addSubview(imageWeather)
        viewForImageTempCity.addSubview(tempLabel)
        
        viewForWindDirectionFells.addSubview(windDirectionView)
        viewForWindDirectionFells.addSubview(feelsLikeLabel)
        windDirectionView.addSubview(windLabel)
        windDirectionView.addSubview(windDirection)
    }
    
    func allConstraints(){
        generalView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewForImageTempCity.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(viewForWindDirectionFells.snp.top)
        }
        
        viewForWindDirectionFells.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        labelCity.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(bigOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalTo(labelCity.snp.width).dividedBy(8)
        }
        
        imageWeather.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(imageWeather.snp.width)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.right.equalTo(imageWeather.snp.right)
            make.top.equalTo(labelCity.snp.bottom)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalTo(tempLabel.snp.width).dividedBy(1.7)
        }
        
        windDirectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(imageWeather)
        }
        
        windLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirectionView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(generalView.snp.bottom)
        }
        
        windDirection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    func updateView(data: MainParsing) {
        addAllViews()
        allConstraints()
        labelCity.text = data.timeZone?.split(separator: "/").last.map(String.init)
        guard let icon = data.current?.weather?[0].icon else {return}
        imageWeather.image = UIImage(named: icon)
        guard let temp = data.current?.temp else {return}
        tempLabel.text = "\(Int(temp.rounded()))"
        guard let wind = data.current?.windSpeed else {return}
        windLabel.text = "\(wind)"+" m/s"
        guard let fellsText = data.current?.feelsLike else {return}
        feelsLikeLabel.text = "Fells like " + "\(Int(fellsText.rounded())) °С"
        viewColorChange(temp: temp)
       
        
        
//        imageWeather.image = UIImage(named: data.current?.weather)
    }
    
    func viewColorChange(temp: Double){
        if temp > 0 {
            view.backgroundColor = .systemOrange
            windDirection.image = .WDH
        } else {
            view.backgroundColor = .systemBlue
            windDirection.image = .WD
        }
    }
    
    func updateWindDirection(radiance: CGFloat) {
        windDirection.transform = CGAffineTransform(rotationAngle: radiance)
    }

}

