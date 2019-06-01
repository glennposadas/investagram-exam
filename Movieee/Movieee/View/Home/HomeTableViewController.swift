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
    
    // MARK: - Functions
    
    private func setupBindings() {
        weak var weakSelf = self
        
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        
        self.viewModel.movieResult.subscribe(onNext: { _ in
            weakSelf?.tableView.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HomeViewModel(homeCnotroller: self)
        self.setupBindings()
    }
}

// MARK: - HomeDelegate

extension HomeTableViewController: HomeDelegate {
    
}

import Foundation
import Moya
import RxCocoa
import RxSwift

/// The delegate of the ```HomeViewModel```
protocol HomeDelegate: class {
    
}

class HomeViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: HomeDelegate?
    
    var movieResult = BehaviorRelay<MovieResult?>(value: nil)
    var movies = [Movie]()
    
    // MARK: Functions
    
    func getTrendingToday() {
        let newPage = self.movieResult.value?.page ?? 1
        APIManager.SearchCalls.getTrendingToday(page: newPage, onSuccess: { (movieResult) in
            guard let movieResult = movieResult, let movies = movieResult.movies else { return }
            _ = movies.map {
                self.movies.append($0)
            }
            self.movieResult.accept(movieResult)
        }) { (errorMessage, _, _) in
            
        }
    }
    
    /// init
    init(homeCnotroller: HomeDelegate?) {
        super.init()
        
        self.delegate = homeCnotroller
        
        self.getTrendingToday()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

// MARK: - UITableViewDataSource

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.setupCell(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
}
