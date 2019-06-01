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
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Functions
    
    private func setupBindings() {
        weak var weakSelf = self
        
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        
        self.viewModel.movieResult.subscribe(onNext: { _ in
            weakSelf?.tableView.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        // Setup tableView
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
        
        // Setup the Search Controller
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Candies"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        self.searchController.searchBar.delegate = self
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

// MARK: - UISearchBarDelegate

extension HomeTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}

// MARK: - UISearchResultsUpdating

extension HomeTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
