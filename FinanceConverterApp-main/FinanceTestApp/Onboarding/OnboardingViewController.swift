//
//  OnboardingViewController.swift
//  AIChatUltra
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit
import SnapKit
import Foundation

class OnboardingViewController: UIViewController {
    
    var viewModel: OnboardingViewModel?

    var data: [CurrencyEntity] = []
    var chosenCurrency = "USD"
    var chosenSign = "$"
    let names: [String] = ["Фунт £", "Лира ₺", "Евро €", "Лари ₾", "Рубль ₽", "Дирхам د.إ", "Доллар $"]


    var fetchData: [CountryEntity] = []
    var currentCellIndex = 0
    let chatCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.register(CurrencyCellCollectionViewCell.self, forCellWithReuseIdentifier: "chatCell")
           return cv
       }()

    let navigationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AveriaLibre-Regular", size: 20)
        label.text = "Chats AI"
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.purple
        button.layer.cornerRadius = 16
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AveriaLibre-Regular", size: 18)
        button.setTitle("Start Out Chat ✨", for: .normal)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    
    let chatContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let robotImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "robot") ?? UIImage())
        image.sizeToFit()
        return image
    }()
    
    let avatarImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "avatar") ?? UIImage())
        image.layer.cornerRadius = 5
        return image
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        prepareData()
        prepareCurrencies()
        chatCollectionView.reloadData()
        print("Appear1 \(data.count)")

    }
    
    func prepareData() {
        fetchData = PersistenceService.shared.getCountries()
        var imageName = "flag_usa"
        for value in fetchData {
            switch value.name {
            case "Фунт £":
               imageName = "flag_uk"
                chosenCurrency = "GBP"
                chosenSign = "£"
            case "Лира ₺":
                imageName = "turkey_flag"
                chosenCurrency = "TRY"
                chosenSign = "₺"


            case "Евро €":
                imageName = "eu_flag"
                chosenCurrency = "EUR"
                chosenSign = "€"


            case "Доллар $":
                 imageName = "flag_usa"
                chosenCurrency = "USD"
                chosenSign = "$"


            case "Дирхам د.إ":
                imageName  = "flag_uae"
                chosenCurrency = "AED"
                chosenSign = "د.إ"


            case "Рубль ₽":
                imageName = "flag_russia"
                chosenCurrency = "RUB"
                chosenSign = "₽"


            case "Лари ₾":
                imageName = "flag_georgia"
                chosenCurrency = "GEL"
                chosenSign = "₾"


            default:
                imageName = "flag_uk"
                chosenCurrency = "GBP"
                chosenSign = "£"


            }
        }

        let logoImage = UIImage.init(named: imageName)
        var button: UIButton = UIButton()
        button.setImage(logoImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action: #selector(changeCountry), for: .touchUpInside)
        var rightItem: UIBarButtonItem = UIBarButtonItem()
        rightItem.customView = button
        rightItem.width = 25
        
        self.navigationItem.leftBarButtonItem = rightItem
    }
    
    func prepareCurrencies () {
        data = []
        var pounds = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "GBP")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(pounds!) £", id: Int(0), icon: UIImage(named: "flag_uk")!))
        
        var liras = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "TRY")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(liras!)₺", id: Int(1), icon: UIImage(named: "turkey_flag")!))
        
        var euro = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "EUR")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(euro!)€", id: Int(2), icon: UIImage(named: "eu_flag")!))
        
        var dollars = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "USD")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(dollars!)$", id: Int(3), icon: UIImage(named: "flag_usa")!))
        
        var dirham = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "AED")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(dirham!)د.إ", id: Int(4), icon: UIImage(named: "flag_uae")!))
        
        var rubles = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "RUB")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(rubles!)₽", id: Int(5), icon: UIImage(named: "flag_russia")!))
        
        var lari = viewModel?.convertValues(firstValue: "\(chosenCurrency)", secondValue: "GEL")
        data.append(CurrencyEntity(name: "1\(chosenSign) = \(lari!)₾", id: Int(6), icon: UIImage(named: "flag_georgia")!))
        chatCollectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
        
        


        view.addSubview(chatCollectionView)

        view.backgroundColor = Colors.hexStringToUIColor(hex: "F2F2F7")
        prepareData()

        chatCollectionView.backgroundColor = Colors.hexStringToUIColor(hex: "F2F2F7")

        
        chatCollectionView.showsHorizontalScrollIndicator = false
        chatCollectionView.dataSource = self
        chatCollectionView.delegate = self
        self.chatCollectionView.alwaysBounceVertical = true

        title = "Курсы"

            setupAlternativeConstraints()
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPressGesture)
        )
        chatCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    
    @objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        let gestureLocation = gesture.location(in: chatCollectionView)

        switch gesture.state {
        case .began:
            guard let targetIndexPath = chatCollectionView.indexPathForItem(at: gesture.location(in: chatCollectionView)) else {return}
            chatCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            chatCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: chatCollectionView))
        case .ended:
            chatCollectionView.endInteractiveMovement()
            chatCollectionView.reloadData()
        default:
            chatCollectionView.cancelInteractiveMovement()
        }
    }
    
   @objc func changeCountry() {
       
       self.navigationController?.pushViewController(ChangeCountryViewController(), animated: true)
    }
    
    
    @objc
    func settingsTapped() {
        viewModel?.navigateToSettings()
        
    }
    @objc
    func example(){
    }
    
    func setupAlternativeConstraints() {
        chatCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupConstraints() {
        chatContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250.0)
        }
        robotImage.snp.makeConstraints { make in
            make.top.equalTo(chatContainer.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(225.0)
            make.height.equalTo(305.0)
        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50.0)
        }
        avatarImage.snp.makeConstraints { make in
            make.width.equalTo(50.0)
            make.height.equalTo(50.0)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
    }
}


extension OnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.90, height: 100.0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("111")

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! CurrencyCellCollectionViewCell

        cell.configureCell(title: data[indexPath.row].name, icon: data[indexPath.row].icon)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = data.remove(at: sourceIndexPath.row)
        data.insert(item, at: destinationIndexPath.row)
        currentCellIndex = destinationIndexPath.row
    }
}
