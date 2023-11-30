//
//  SettingsViewController.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit
import SafariServices
import SnapKit
import StoreKit


class SettingsViewController: UIViewController {
    
    let data: [SettingsRowModel] = [
        SettingsRowModel(name: "Оценить приложение", icon: UIImage(named: "starIcon")!, tag: .rating),
        SettingsRowModel(name: "Политика конфиденциальности", icon: UIImage(named: "privacyIcon")!, tag: .privacyPolicy),
        SettingsRowModel(name: "Связаться с нами", icon: UIImage(named: "contactIcon")!, tag: .contact),
        SettingsRowModel(name: "Поделиться", icon: UIImage(named: "shareIcon")!, tag: .share)
    ]
    
    var versionLabel: UILabel = {
          let label = UILabel()
          label.text = "Version app: 1.1"
          label.font = UIFont(name: "AveriaLibre-Regular", size: 16)
          label.textColor = .black
          return label
      }()
    
    var viewModel: SettingsViewModel?

    let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = Colors.lightYellow
        title = "Настройки"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AveriaLibre-Regular", size: 27)!]
        self.navigationController?.navigationBar.tintColor = Colors.lightYellow
        versionLabel.textColor = .darkGray
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(versionLabel)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "ChatAI", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(340)
        }
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    func openURL(url: String) {
        guard let url = URL(string: url) else {
                    return
                }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
    func presentTheShare() {
        let url = URL(string: "https://sites.google.com/view/developerwebsiteofconverter?usp=sharing")!
        
        let shareVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareVC, animated: true)
        
    }
    
    func askReview() {
        guard let scene = view.window?.windowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: scene)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        cell.configure(icon: data[indexPath.row].icon, title: data[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data[indexPath.row].tag {
        case .contact:
            self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
            break
        case .privacyPolicy:
            openURL(url: Constants.privacyPolicy)
            break
        case .rating:
            askReview()
        case .share:
            presentTheShare()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


private struct Constants {
    static let privacyPolicy = "https://sites.google.com/view/privacypolicyofconferter?usp=sharing"
}
