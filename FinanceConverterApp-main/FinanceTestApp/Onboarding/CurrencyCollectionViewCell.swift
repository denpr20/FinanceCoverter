//
//  CurrencyCollectionViewCell.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit
import Foundation
import SnapKit

protocol UpdateCollectionViewDelegate: AnyObject {
    func updateCollectionView(_ data: String)
}

class CurrencyCellCollectionViewCell: UICollectionViewCell {

    var id = 0
    var isSaved = false
        
    lazy var icon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "saveIcon"))
       
        return image
    }()
    
    let value: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AveriaLibre-Regular", size: 28)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AveriaLibre-Regular", size: 11)
        label.textColor = Colors.darkGray
        label.numberOfLines = 3
        return label
    }()
    
    var tap: UITapGestureRecognizer {
        let t = UITapGestureRecognizer(target: self, action: #selector(addToSaved))
        return t
    }
    
    var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    
    func configureCell(title: String, icon: UIImage) {
       

        contentView.addSubview(containerView)
        containerView.addSubview(self.value)
        containerView.addSubview(self.icon)
        contentView.backgroundColor = Colors.hexStringToUIColor(hex: "F2F2F7")
        containerView.backgroundColor = .white
        
        
        self.icon.image = icon
        
        self.value.text = title

        setupConstraints()
    }
    
    @objc
    func addToSaved() {
        if isSaved {

            icon.image = UIImage(named: "saveIcon")
            isSaved.toggle()

        } else {

            icon.image = UIImage(named: "saveIcon2")
            isSaved.toggle()
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
            make.top.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(46)
            make.height.equalTo(46)
            make.centerY.equalToSuperview()
        }
        
        value.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(120)
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            contentView.layer.cornerRadius = 8
            containerView.layer.cornerRadius = 8
            containerView.layer.shadowOpacity = 0.25
            containerView.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
