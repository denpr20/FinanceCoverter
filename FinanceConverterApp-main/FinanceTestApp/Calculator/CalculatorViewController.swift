//
//  CalculatorViewController.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {

    var viewModel: CalculatorViewModel?
    
    var offsetY:CGFloat = 0
    var rowHeight = 200.0
    
    var selectedFirst = 0
    var selectedSecond = 0

    
    var label1: UILabel = {
        let label = UILabel()
        label.text = "Выберите валюту,которую хотите перевести"
        label.font = UIFont(name: "AveriaLibre-Regular", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var button: UIButton = {
       let button = UIButton()
        button.setTitle("Конвертировать", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    var textField1: UITextField = {
        let textField = CustomTextField(placeHolder: "Введите значение")
        textField.backgroundColor = .white
        textField.keyboardType = .asciiCapableNumberPad

        textField.enablesReturnKeyAutomatically = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    var textField2: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: "Enter value", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        textField.attributedPlaceholder = attributedPlaceholder
        textField.backgroundColor = .white
        textField.keyboardType = .asciiCapableNumberPad

        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    var label2: UILabel = {
        let label = UILabel()
        label.text = "Введите валюту, на которую хотите перевести"
        label.font = UIFont(name: "AveriaLibre-Regular", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let data: [String] = ["Фунт £", "Лира ₺", "Евро €", "Лари ₾", "Рубль ₽", "Дирхам د.إ", "Доллар $"]
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let data2: [String] = ["Фунт £", "Лира ₺", "Евро €", "Лари ₾", "Рубль ₽", "Дирхам د.إ", "Доллар $"]
    
    let tableView2: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 450)

    }
    
    @objc func keyboardWillShow(notification: Notification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
                textField1.text = " "
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets

                var rect = view.frame
                rect.size.height -= keyboardSize.height
                if !rect.contains(textField1.frame.origin) {
                    scrollView.scrollRectToVisible(textField1.frame, animated: true)
                }
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        button.addTarget(self, action: #selector(makeConvertation), for: .touchUpInside)

        textField1.addTarget(self, action: #selector(textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)

        scrollView.isUserInteractionEnabled = true

        scrollView.clipsToBounds = true
        rowHeight = Double(50 * data.count)

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        title = "Конвертер валют"
        view.backgroundColor = Colors.hexStringToUIColor(hex: "F2F2F7")
        
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = Colors.hexStringToUIColor(hex: "F2F2F7")

        scrollView.addSubview(label1)
        scrollView.addSubview(tableView)
        scrollView.addSubview(label2)
        scrollView.addSubview(tableView2)
        scrollView.addSubview(textField1)
        scrollView.addSubview(button)
        scrollView.addSubview(textField2)

        tableView.register(ChangeCountryTableViewCell.self, forCellReuseIdentifier: ChangeCountryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5
        tableView.tag = 1
        
        textField1.delegate = self


        tableView2.register(ChangeCountryTableViewCell.self, forCellReuseIdentifier: ChangeCountryTableViewCell.identifier)
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.layer.cornerRadius = 5
        tableView2.tag = 2

        scrollView.addSubview(button)
        configureUI()
    }
    
    
    @objc func makeConvertation() {
        var answer  = viewModel?.convertValues(firstValue: data[selectedFirst], secondValue: data2[selectedSecond], enteredNumber: Int(textField1.text ?? "5") ?? 5)
        view.endEditing(true)

        
        textField2.text = "\(answer!) \(data2[selectedSecond])"
        
    }
    
    @objc func textFieldEditingDidEndOnExit() {
            textField1.resignFirstResponder()
        view.endEditing(true)
        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    @objc func keyboardFrameChangeNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
            let animationCurveRawValue = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int) ?? Int(UIView.AnimationOptions.curveEaseInOut.rawValue)
            let animationCurve = UIView.AnimationOptions(rawValue: UInt(animationCurveRawValue))
          if let _ = endFrame, endFrame!.intersects(self.textField1.frame) {
            self.offsetY = self.textField1.frame.maxY - endFrame!.minY
            UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
              self.textField1.frame.origin.y = self.textField1.frame.origin.y - self.offsetY
            }, completion: nil)
          } else {
            if self.offsetY != 0 {
              UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
                self.textField1.frame.origin.y = self.textField1.frame.origin.y + self.offsetY
                self.offsetY = 0
              }, completion: nil)
            }
          }
        }
      }
    func configureUI() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            label1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
            label1.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            label1.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
            tableView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: rowHeight)
        ])
        
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            label2.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
            label2.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            label2.heightAnchor.constraint(equalToConstant: 25)
        ])
        NSLayoutConstraint.activate([
            tableView2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            tableView2.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
            tableView2.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            tableView2.heightAnchor.constraint(equalToConstant: rowHeight)
        ])
        NSLayoutConstraint.activate([
            textField1.topAnchor.constraint(equalTo: tableView2.bottomAnchor, constant: 30),
            textField1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 50),
            textField1.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            textField1.heightAnchor.constraint(equalToConstant: 50),
            textField1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 180),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            textField2.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 50),
            textField2.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            textField2.heightAnchor.constraint(equalToConstant: 50),
            textField2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(800)
        }
        label1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(25.0)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(1000)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(135)
        }
        
        label2.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(25.0)
        }
        
        tableView2.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(135)
        }
        
        textField1.snp.makeConstraints { make in
            make.top.equalTo(tableView2.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
      
        button.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(110)
        }
        
        textField2.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}


extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return data.count

        } else {
            return data2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeCountryTableViewCell.identifier, for: indexPath) as? ChangeCountryTableViewCell else { return UITableViewCell() }
        if tableView.tag == 1 {
            cell.configure(icon: UIImage(named: "checkMark")!, title: data[indexPath.row])
            if indexPath.row == selectedFirst {
                cell.isSelectedVal = true
                cell.checkMark.isHidden = false
            } else {
                cell.isSelectedVal = false
                cell.checkMark.isHidden = true
                
            }

        } else {
            cell.configure(icon: UIImage(named: "checkMark")!, title: data2[indexPath.row])
            if indexPath.row == selectedSecond {
                cell.isSelectedVal = true
                cell.checkMark.isHidden = false
            } else
            {
                cell.isSelectedVal = false
                cell.checkMark.isHidden = true
                
            }
            

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            let cell = tableView.cellForRow(at: indexPath) as! ChangeCountryTableViewCell
            
            if indexPath.row != selectedFirst {
                cell.isSelectedVal = true
                cell.checkMark.isHidden = false
                selectedFirst = indexPath.row

                tableView.reloadData()
                tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                tableView.reloadData()
                tableView.reloadRows(at: [indexPath], with: .none)

            }

        } else {
            let cell = tableView.cellForRow(at: indexPath) as! ChangeCountryTableViewCell
            
            if indexPath.row != selectedSecond {
                cell.isSelectedVal = true
                cell.checkMark.isHidden = false
                selectedSecond = indexPath.row

                tableView.reloadData()
                tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                tableView.reloadData()
                tableView.reloadRows(at: [indexPath], with: .none)

            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
