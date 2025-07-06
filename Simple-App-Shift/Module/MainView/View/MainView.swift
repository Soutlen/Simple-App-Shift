//
//  MainView.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
}

class MainView: UIViewController, MainViewProtocol, UITableViewDataSource {
    var presenter: MainPresenterProtocol!
    
    lazy var greetingsText: UIButton = {
        $0.setTitle("Greetings!", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(grettingsButtonTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    lazy var tableView: UITableView = {
        $0.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        $0.dataSource = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.fetchAllData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Ок",
            style: .default))
        present(alert, animated: true)
    }
    
    @objc func grettingsButtonTapped() {
        let name = UserDefaults.standard.string(forKey: "userFirstName") ?? "Пользователь"
        let alert = UIAlertController(
            title: "Приветсвуем!",
            message: "\(name)",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Ок",
            style: .default))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(greetingsText)
        
        NSLayoutConstraint.activate(
            [
                greetingsText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                greetingsText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                greetingsText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                tableView.topAnchor.constraint(equalTo: greetingsText.bottomAnchor, constant: 30),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}

extension MainView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell,
              let model = (presenter as? MainPresenter)?.dataProduct[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
}
