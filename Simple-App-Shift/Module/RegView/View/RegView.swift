//
//  RegView.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import UIKit

protocol RegViewProtocol: AnyObject {
    var firstName: UITextField { get }
    var lastName: UITextField { get }
    var passwordField: UITextField { get }
    var checkPasswordField: UITextField { get }
    var buttonReg: UIButton { get }
}

class RegView: UIViewController, RegViewProtocol {
    
    var presenter: RegPresenterProtocol!
    
    lazy var firstName: UITextField = {
        $0.text = ""
        $0.placeholder = "Введите имя"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.systemPink.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 8
        $0.keyboardType = .default
        $0.returnKeyType = .done
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var lastName: UITextField = {
        $0.text = ""
        $0.placeholder = "Введите фамилию"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.systemPink.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 8
        $0.keyboardType = .default
        $0.returnKeyType = .done
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var passwordField: UITextField = {
        $0.text = ""
        $0.placeholder = "Введите пороль"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.keyboardType = .default
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.systemPink.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 8
        $0.returnKeyType = .done
        $0.isSecureTextEntry = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var checkPasswordField: UITextField = {
        $0.text = ""
        $0.placeholder = "Повторите пороль"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.systemPink.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 8
        $0.keyboardType = .default
        $0.returnKeyType = .done
        $0.isSecureTextEntry = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var buttonReg: UIButton = {
        $0.setTitle("Reg", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(registrationTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    lazy var datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .compact
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    @objc func dateChange() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
    }
    
    @objc func textFieldsDidChange() {
        let allFilled = !(firstName.text?.isEmpty ?? true)
        && !(lastName.text?.isEmpty ?? true)
        && !(passwordField.text?.isEmpty ?? true)
        && !(checkPasswordField.text?.isEmpty ?? true)
        buttonReg.isEnabled = allFilled
        buttonReg.alpha = allFilled ? 1 : 0.5
    }
    
    @objc func registrationTapped() {
        let errors = presenter.validateFields()
        if errors.isEmpty {
            UserDefaults.standard.set(firstName.text ?? " ", forKey: "userFirstName")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
            let mainVC = Builder.createMainViewController()
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true)
        } else {
            let alert = UIAlertController(
                title: "Ошибка",
                message: errors.joined(separator: "\n"),
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        firstName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        lastName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        checkPasswordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        textFieldsDidChange()
    }
    
    private func setupUI() {
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(passwordField)
        view.addSubview(checkPasswordField)
        view.addSubview(buttonReg)
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate(
            [
                firstName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                firstName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                firstName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                firstName.heightAnchor.constraint(equalToConstant: 60),
                
                lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 15),
                lastName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                lastName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                lastName.heightAnchor.constraint(equalToConstant: 60),
                
                passwordField.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 15),
                passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                passwordField.heightAnchor.constraint(equalToConstant: 60),
                
                checkPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15),
                checkPasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                checkPasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                checkPasswordField.heightAnchor.constraint(equalToConstant: 60),
                
                datePicker.topAnchor.constraint(equalTo: checkPasswordField.bottomAnchor, constant: 15),
                datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                datePicker.heightAnchor.constraint(equalToConstant: 60),
                
                buttonReg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
                buttonReg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                buttonReg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                buttonReg.heightAnchor.constraint(equalToConstant: 60),
            ]
        )
    }
}
