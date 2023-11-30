//
//  ChangeCountryTableViewCell.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit

class ChangeCountryTableViewCell: UITableViewCell {

    static let identifier = "ChangeCountryTableViewCell"

    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Allerta-Regular", size: 20)
        return label
    }()
    
    let checkMark: UIImageView = {
        let image = UIImageView(image: UIImage(named: "checkMark"))
        
        return image
    }()
    
    var isSelectedVal: Bool = false
    
    
    // MARK: - Cell initialisation
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(checkMark)
        contentView.addSubview(title)
        checkMark.isHidden = !isSelectedVal

        setupConstraints()
    }
    
    func reDraw() {
        
    }
    
    func configure(icon: UIImage, title: String) {
        self.title.text = title
        checkMark.isHidden = !isSelectedVal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        checkMark.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(12)
            make.width.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
