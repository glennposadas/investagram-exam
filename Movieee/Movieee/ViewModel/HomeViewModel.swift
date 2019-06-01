//
//  HomeViewModel.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

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
    
    var lastPageRequested = -1
    var currentPage: Int = 1
    var lastPage: Int = 100
    var lastPageReached: Bool = false
    
    // MARK: Functions
    
    func getTrendingToday() {
        if self.lastPageRequested == self.currentPage {
            print("Not so fast...")
            return
        }
        
        print("Fetching page: \(self.currentPage)")
        
        self.lastPageRequested = self.currentPage
        
        APIManager.SearchCalls.getTrendingToday(page: self.currentPage, onSuccess: { (movieResult) in
            guard let movieResult = movieResult, let movies = movieResult.movies else { return }
            
            self.currentPage = movieResult.page ?? 1
            self.lastPage = (movieResult.totalPages ?? 1)
            self.lastPageReached = self.currentPage >= self.lastPage
            
            _ = movies.map {
                self.movies.append($0)
            }
            self.movieResult.accept(movieResult)
        }) { (errorMessage, _, _) in
            // TODO: Handle errors.
            print("Error: \(errorMessage)")
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            if self.movieResult.value?.page == self.movieResult.value?.totalPages {
                let transluscentView = UIView()
                transluscentView.backgroundColor = .clear
                tableView.tableFooterView = transluscentView
                return
            }
            
            // Reload new page.
            
            print("Reloading new page 🔔")
            
            self.currentPage = self.currentPage + 1
            self.getTrendingToday()
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
}

