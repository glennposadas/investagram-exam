//
//  HomeTableViewController.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 31/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()

    private lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    // MARK: - Functions
    
    private func setupBindings() {
        weak var weakSelf = self
        
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        
        self.viewModel.movieResult.subscribe(onNext: { _ in
            weakSelf?.tableView.reloadData()
        }).disposed(by: self.disposeBag)
        
        self.viewModel.movieResultForSearch.subscribe(onNext: { _ in
            weakSelf?.tableView.reloadData()
        }).disposed(by: self.disposeBag)
        
        self.searchController.rx.didPresent.subscribe { _ in
            weakSelf?.viewModel.userIsSearching.accept(true)
        }.disposed(by: self.disposeBag)
        
        self.searchController.rx.didDismiss.subscribe { _ in
            weakSelf?.viewModel.userIsSearching.accept(false)
            }.disposed(by: self.disposeBag)
        
        self.searchController.searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .bind(to: self.viewModel.query)
            .disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        // Setup tableView
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
        self.tableView.keyboardDismissMode = .interactive
        
        // Setup the Search Controller
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search For Movies"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HomeViewModel(homeCnotroller: self)
        self.setupBindings()
        self.setupUI()
    }
}

// MARK: - HomeDelegate

extension HomeTableViewController: HomeDelegate {
    
}

// MARK: - UISearchResultsUpdating

extension HomeTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /*let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        self.viewModel.search(searchBar.text!)*/
    }
}
