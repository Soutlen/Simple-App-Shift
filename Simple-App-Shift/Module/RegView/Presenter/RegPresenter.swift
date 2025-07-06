//
//  RegPresenter.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import Foundation

protocol RegPresenterProtocol: AnyObject {
    func validateFields() -> [String]
}

class RegPresenter: RegPresenterProtocol {
    weak var view: RegViewProtocol?
    
    init(view: RegViewProtocol?) {
        self.view = view
    }

    func validateFields() -> [String] {
        var errors: [String] = []
        
        if let first = view?.firstName.text, first.count < 2 || !first.allSatisfy({ $0.isLetter }) {
            errors.append("Имя должно содержать минимум 2 буквы и только буквы")
        }
        
        if let last = view?.lastName.text, last.count < 2 || !last.allSatisfy({ $0.isLetter }) {
            errors.append("Фамилия должна содержать минимум 2 буквы и только буквы")
        }
        
        if let pass = view?.passwordField.text {
               if pass.count < 8 ||
                   pass.rangeOfCharacter(from: .lowercaseLetters) == nil ||
                   pass.rangeOfCharacter(from: .decimalDigits) == nil ||
                   pass.rangeOfCharacter(from: .uppercaseLetters) == nil {
                   errors.append("Пароль должен содержать минимум 8 символов, букву в верхнем регистре, цифру и строчную букву")
               }
           } else {
               errors.append("Пароль не введён")
           }
           
           if let pass = view?.passwordField.text, let check = view?.checkPasswordField.text, check != pass {
               errors.append("Пароли не совпадают")
           }
        
        return errors
    }
    
}
