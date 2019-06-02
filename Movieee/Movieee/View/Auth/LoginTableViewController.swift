//
//  LoginTableViewController.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 31/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class LoginTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var textField_Email: UITextField!
    @IBOutlet weak var textField_Password: UITextField!
    @IBOutlet weak var button_Login: UIButton!
    
    // MARK: - Functions
    
    private func setupBindings() {
        weak var weakSelf = self
        
        self.button_Login.rx.tap.subscribe { _ in
            weakSelf?.viewModel.login()
            }.disposed(by: self.disposeBag)
        
        self.textField_Email.rx.controlEvent(.editingDidEndOnExit).subscribe { _ in
            _ = weakSelf?.textField_Password.becomeFirstResponder()
            }.disposed(by: self.disposeBag)
        
        self.textField_Password.rx.controlEvent(.editingDidEndOnExit).subscribe { _ in
            _ = weakSelf?.viewModel.login()
            }.disposed(by: self.disposeBag)
        
        self.textField_Email.rx.text
            .orEmpty
            .bind(to: self.viewModel.email)
            .disposed(by: self.disposeBag)
        
        self.textField_Password.rx.text
            .orEmpty
            .bind(to: self.viewModel.password)
            .disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        // Setup tableView
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
        self.tableView.keyboardDismissMode = .interactive
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = LoginViewModel(loginController: self)
        self.setupBindings()
        self.setupUI()
    }
}

// MARK: - LoginDelegate

extension LoginTableViewController: LoginDelegate {
    func presentAlert(title: String, message: String, firstButtonTitle: String) {
        self.alert(title: title, message: message, okayButtonTitle: firstButtonTitle)
    }
}
