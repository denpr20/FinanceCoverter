//
//  ContactUsViewController.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Fill in the fields below so we can contact you"
        label.font = UIFont(name: "AveriaLibre-Regular", size: 17)
        label.textColor = .black
        return label
    }()
    
    var firstNameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "First Name:")
        textField.backgroundColor = .clear
        textField.addBottomBorder(with: .lightGray, andWidth: 0.5)
        return textField
    }()
    
    var secondNameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Seconds Name:")
        textField.backgroundColor = .clear
        textField.addBottomBorder(with: .lightGray, andWidth: 0.5)
        return textField
    }()
    
    var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email:")
        textField.backgroundColor = .clear
        textField.addBottomBorder(with: .lightGray, andWidth: 0.5)

        return textField
    }()
    
    var button: UIButton = {
       let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont(name: "AveriaLibre-Regular", size: 17)
       return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        view.backgroundColor = .white

        view.addSubview(label)
        view.addSubview(firstNameTextField)
        view.addSubview(secondNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(button)

        setupConstraints()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func setupConstraints() {
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(25.0)
        }
                
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        secondNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(secondNameTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
      
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
    }
}
