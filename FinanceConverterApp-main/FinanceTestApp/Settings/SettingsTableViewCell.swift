//
//  SettingsTableViewCell.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit
import Foundation
import SnapKit


class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    
    static let identifier = "SettingsTableViewCell"
    let icon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "saveIcon"))
        image.tintColor = Colors.lightYellow
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Allerta-Regular", size: 20)
        return label
    }()
    
    
    // MARK: - Cell initialisation
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        contentView.addSubview(title)

        setupConstraints()
    }
    
    func configure(icon: UIImage, title: String) {
        self.icon.image = icon
        self.title.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.trailing.equalToSuperview()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

