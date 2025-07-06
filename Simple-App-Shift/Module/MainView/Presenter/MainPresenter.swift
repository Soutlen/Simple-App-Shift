//
//  MainPresenter.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    func fetchAllData()
    var dataProduct: [ModelFakeStore] { get }
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let network: NetworkManagerProtocol
    var dataProduct: [ModelFakeStore] = []
    
    init(view: MainViewProtocol?, network: NetworkManagerProtocol) {
        self.view = view
        self.network = network
    }
    
    func fetchAllData() {
        network.fetchData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let products):
                    self.dataProduct = products
                    self.view?.reloadData()
                case .failure(let error):
                    self.view?.showError(error.message)
                }
            }
        }
    }
}
