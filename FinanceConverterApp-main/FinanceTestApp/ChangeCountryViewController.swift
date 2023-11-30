//
//  ChangeCountryViewController.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit
import DeviceKit

class ChangeCountryViewController: UIViewController {

    
    
    let data: [String] = ["Фунт £", "Лира ₺", "Евро €", "Лари ₾", "Рубль ₽", "Дирхам د.إ", "Доллар $"]
    
    var viewModel: SettingsViewModel?

    let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = Colors.lightYellow
        title = "Смена основного курса"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AveriaLibre-Regular", size: 27)!]
        self.navigationController?.navigationBar.tintColor = Colors.lightYellow
        
        view.addSubview(tableView)
        tableView.register(ChangeCountryTableViewCell.self, forCellReuseIdentifier: ChangeCountryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5
        view.backgroundColor = Colors.hexStringToUIColor(hex: "F2F2F7")

        setupConstraints()

    }
    override func viewWillAppear(_ animated: Bool) {
        print("Appear")
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(45 * data.count)
        }
        
        
    }

}



extension ChangeCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeCountryTableViewCell.identifier, for: indexPath) as? ChangeCountryTableViewCell else { return UITableViewCell() }
        var array = PersistenceService.shared.getCountries()
        if array.count == 0 {
            if indexPath.row == 0 {
                PersistenceService.shared.saveNewCountry(country: CountryEntity(id: Int64(indexPath.row), name: data[indexPath.row]))
                cell.isSelectedVal = true
                cell.configure(icon: UIImage(named: "checkMark")!, title: data[indexPath.row])
            }
        }

        for value in array {
            if Int(value.id) == indexPath.row {
                
                cell.isSelectedVal = true
                cell.configure(icon: UIImage(named: "checkMark")!, title: data[indexPath.row])
                break
            } else {
                
                cell.isSelectedVal = false
                cell.configure(icon: UIImage(named: "checkMark")!, title: data[indexPath.row])
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
        let cell = tableView.cellForRow(at: indexPath) as! ChangeCountryTableViewCell
        
        
        if cell.isSelectedVal == false {
            
            cell.isSelectedVal = true
            cell.checkMark.isHidden = false
            PersistenceService.shared.deleteAllCountries()
            PersistenceService.shared.saveNewCountry(country: CountryEntity(id: Int64(indexPath.row), name: data[indexPath.row]))
            tableView.reloadData()
            tableView.reloadRows(at: [indexPath], with: .none)            
        }
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

enum MyError: Error {
    case runtimeError(String)
}
