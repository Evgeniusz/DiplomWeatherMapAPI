//
//  TableViewCityFoundList.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 15.02.26.
//
import UIKit
import SnapKit

final class TableViewCityFoundList: UITableViewCell {
    
        static var identifire: String {"\(Self.self)"}
        
        private let cityName: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .white
            label.backgroundColor = .clear
            label.font = .systemFont(ofSize: 25, weight: .thin)
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configureCell()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configureCell() {
            contentView.addSubview(cityName)
            backgroundColor = .clear
            contentView.backgroundColor = .clear
            cityName.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(2)
                make.bottom.equalToSuperview().offset(-2)
            }
        }
        
        func configure(object: CityNames){
            cityName.text = object.localNames + " / " + object.country
        }
        
        override func prepareForReuse() {
            cityName.text = nil
        }
}
