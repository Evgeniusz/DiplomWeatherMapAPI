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
    var cityArrayFromBack: [CityNames] {get set}
    func addTableView()
    var tableView: UITableView {get set}
}

class ViewController: UIViewController, CLLocationManagerDelegate, IView {
//    let network: iNetworkService = NetworkService()
    let locationManager = LocationManager.shared
    private let presenter: IPresenter
    var cityArrayFromBack = [CityNames]()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(TableViewCity.self, forCellReuseIdentifier: TableViewCity.identifire)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let bigOffset: CGFloat = 50
    let standartOffset: CGFloat = 16
    let buttonStandartHeight: CGFloat = 30
    var windSpeed: Double = 4.01
    
    private let currentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Current Geo Location", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .thin)
        return button
    }()
    
    private let textFieldCityRequest: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Find City"
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 25, weight: .thin)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let buttonFindForTextField: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.glass, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let burgerButtion: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("☰", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        return button
    }()
    
    private let generalView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private let generalViewForMenu: UIView = {
        let view = UIView()
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
        label.font = .systemFont(ofSize: 50, weight: .light)
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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 120, weight: .thin)
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
        label.text = "No data, check for e connection"
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
        burgerButtonAction()
        currentButtonAction()
        start()
        textFieldCityRequest.delegate = self
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
        view.addSubview(generalViewForMenu)
        view.addSubview(burgerButtion)
        generalView.addSubview(viewForImageTempCity)
        generalView.addSubview(viewForWindDirectionFells)
        viewForImageTempCity.addSubview(labelCity)
        viewForImageTempCity.addSubview(imageWeather)
        viewForImageTempCity.addSubview(tempLabel)
        
        viewForWindDirectionFells.addSubview(windDirectionView)
        viewForWindDirectionFells.addSubview(feelsLikeLabel)
        windDirectionView.addSubview(windLabel)
        windDirectionView.addSubview(windDirection)
        
        generalViewForMenu.addSubview(currentButton)
        generalViewForMenu.addSubview(buttonFindForTextField)
        generalViewForMenu.addSubview(textFieldCityRequest)
    }
    
    func allConstraints(){
        generalView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        generalViewForMenu.snp.makeConstraints { make in
            make.width.height.equalTo(generalView)
            make.right.equalTo(generalView.snp.left)
            make.top.equalTo(generalView.snp.top)
        }
        
        burgerButtion.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(standartOffset)
            make.top.equalToSuperview().offset(bigOffset)
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
            make.height.equalTo(labelCity.snp.width).dividedBy(4)
        }
        
        imageWeather.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(imageWeather.snp.width)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(labelCity.snp.top).offset(bigOffset)
            make.width.equalToSuperview()
            make.height.equalTo(tempLabel.snp.width).dividedBy(3)
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
        
        currentButton.snp.makeConstraints { make in
            make.top.equalTo(labelCity.snp.top).offset(standartOffset)
            make.left.right.equalToSuperview()
            make.height.equalTo(standartOffset).multipliedBy(2)
        }
        
        buttonFindForTextField.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(standartOffset)
            make.top.equalTo(currentButton.snp.bottom).offset(standartOffset)
            make.width.height.equalTo(buttonStandartHeight)
        }
        
        textFieldCityRequest.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(bigOffset)
            make.right.equalTo(buttonFindForTextField.snp.left).offset(-standartOffset)
            make.top.bottom.equalTo(buttonFindForTextField)
        }
        
        
    }
    
    func updateView(data: MainParsing) {
        addAllViews()
        allConstraints()
        guard let timeZone = data.timeZone else {return}
        labelCity.text = timeZone.split(separator: "/").last.map(String.init)
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
            generalView.backgroundColor = .systemOrange
            view.backgroundColor = .systemOrange
            windDirection.image = .WDH
            tableView.backgroundColor = view.backgroundColor
        } else {
            generalView.backgroundColor = .systemBlue
            windDirection.image = .WD
            view.backgroundColor = .systemBlue
            tableView.backgroundColor = view.backgroundColor
        }
    }
    
    func updateWindDirection(radiance: CGFloat) {
        windDirection.transform = CGAffineTransform(rotationAngle: radiance)
    }
    
    func burgerButtonAction() {
        let action = UIAction {_ in
            self.menuMotion()
        }
        burgerButtion.addAction(action, for: .touchUpInside)
    }
    
    func menuMotion() {
        if self.generalView.frame.origin.x == 0 {
            self.generalViewForMenu.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            self.generalView.snp.remakeConstraints { make in
                make.width.height.equalToSuperview()
                make.left.equalTo(self.generalViewForMenu.snp.right)
            }

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.generalView.alpha = 0
            }
        } else {
            self.generalViewForMenu.snp.remakeConstraints { make in
                make.width.height.equalToSuperview()
                make.right.equalTo(self.generalView.snp.left)
            }
            self.generalView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.generalView.alpha = 1
            }
        }
    }
    
    func currentButtonAction(){
        let action = UIAction {_ in
            self.presenter.cityRequest()
            self.menuMotion()
        }
        currentButton.addAction(action, for: .touchUpInside)
    }
    
    func findCity() {
        guard let text = textFieldCityRequest.text else {return}
        presenter.findCityRequest(city: text)
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.isHidden = false
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(textFieldCityRequest)
            make.top.equalTo(textFieldCityRequest.snp.bottom)
            make.height.equalTo(100) //question need to? its scrolable, auto content?
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityArrayFromBack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCity.identifire, for: indexPath) as? TableViewCity else {return UITableViewCell()}
        cell.configure(object: cityArrayFromBack[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canPerformPrimaryActionForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        // прописать сохранение передачу кнопки, запрос на вывод города, переход на экран
        let object = cityArrayFromBack[indexPath.row]
        let newCoordinates = Coordinates(lat: object.lat, lon: object.lon)
        presenter.cityRequestFromTableViewByCoordinates(coordinates: newCoordinates)
        tableView.removeFromSuperview()
        cityArrayFromBack.removeAll()
        textFieldCityRequest.text = ""
        menuMotion()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        findCity()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
                return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }
}
