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
    
    private let disposeBag = DisposeBag()
    
    var userIsSearching = BehaviorRelay<Bool>(value: false)
    
    var query = BehaviorRelay<String>(value: "")
    var lastQuery = BehaviorRelay<String>(value: "")
    var movieResultForSearch = BehaviorRelay<MovieResult?>(value: nil)
    var moviesForSearch = [Movie]()
    
    var lastPageRequestedForSearch = -1
    var currentPageForSearch: Int = 1
    var lastPageForSearch: Int = 100
    var lastPageReachedForSearch: Bool = false
    
    var movieResult = BehaviorRelay<MovieResult?>(value: nil)
    var movies = [Movie]()
    
    var lastPageRequested = -1
    var currentPage: Int = 1
    var lastPage: Int = 100
    var lastPageReached: Bool = false
    
    // MARK: Functions
    
    func getTrendingToday(showHUD: Bool = true) {
        if self.lastPageRequested == self.currentPage {
            print("Not so fast...")
            return
        }
        
        print("Fetching page: \(self.currentPage)")
        
        self.lastPageRequested = self.currentPage
        
        APIManager.SearchCalls.getTrendingToday(page: self.currentPage, showHUD: showHUD, onSuccess: { (movieResult) in
            self.handleMovieResult(movieResult)
            
        }) { (errorMessage, _, _) in
            // TODO: Handle errors.
            print("Error: \(errorMessage)")
        }
    }
    
    func search(_ query: String, showHUD: Bool = true) {
        print("Searching: \(query) | Last Page Requested: \(self.lastPageRequestedForSearch)")
        
        if query != self.lastQuery.value {
            self.resetForSearchProperties()
        }
        
        APIManager.SearchCalls.search(query, page: self.currentPageForSearch, showHUD: showHUD, onSuccess: { (movieResult) in
            self.handleMovieResult(movieResult)
            self.lastQuery.accept(query)
            
        }) { (errorMessage, _, _) in
            // TODO: Handle errors.
            print("Error: \(errorMessage)")
        }
    }
    
    func handleMovieResult(_ movieResult: MovieResult?) {
        guard let movieResult = movieResult, let movies = movieResult.movies else { return }

        if self.userIsSearching.value {
            self.currentPageForSearch = movieResult.page ?? 1
            self.lastPageForSearch = (movieResult.totalPages ?? 1)
            self.lastPageReachedForSearch = self.currentPageForSearch >= self.lastPageForSearch
            
            _ = movies.map {
                self.moviesForSearch.append($0)
            }
            self.movieResultForSearch.accept(movieResult)
            
        } else {
            self.currentPage = movieResult.page ?? 1
            self.lastPage = (movieResult.totalPages ?? 1)
            self.lastPageReached = self.currentPage >= self.lastPage
            
            _ = movies.map {
                self.movies.append($0)
            }
            self.movieResult.accept(movieResult)
        }
    }
    
    func resetForSearchProperties() {
        self.moviesForSearch.removeAll()
        
        self.lastPageRequestedForSearch = -1
        self.currentPageForSearch = 1
        self.lastPageForSearch = 100
        self.lastPageReachedForSearch = false
        
        self.movieResultForSearch.accept(nil)
    }
    
    /// init
    init(homeCnotroller: HomeDelegate?) {
        super.init()
        
        self.delegate = homeCnotroller
        
        self.getTrendingToday()
        
        weak var weakSelf = self
        
        // Observe query relay by user
        self.query.subscribe(onNext: { newQuery in
            weakSelf?.search(newQuery)
        }).disposed(by: self.disposeBag)
        
        // Observe `userIsSearching` relay.
        self.userIsSearching.subscribe(onNext: { isSearching in
            weakSelf?.resetForSearchProperties()
        }).disposed(by: self.disposeBag)

    }
}

// MARK: - UITableViewDelegate

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let _ = self.userIsSearching.value ? self.moviesForSearch[indexPath.row] : self.movies[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.userIsSearching.value ? self.moviesForSearch[indexPath.row] : self.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.setupCell(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userIsSearching.value ? self.moviesForSearch.count: self.movies.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            func removeFooter() {
                let transluscentView = UIView()
                transluscentView.backgroundColor = .clear
                tableView.tableFooterView = transluscentView
            }
            
            if self.userIsSearching.value {
                
                if self.movieResultForSearch.value?.page == self.movieResultForSearch.value?.totalPages {
                    removeFooter()
                    return
                }
                
                // Load new page
                self.currentPageForSearch = self.currentPageForSearch + 1
                self.search(self.query.value, showHUD: false)
                
            } else {
                
                if self.movieResult.value?.page == self.movieResult.value?.totalPages {
                    removeFooter()
                    return
                }
                
                // Load new page
                self.currentPage = self.currentPage + 1
                self.getTrendingToday(showHUD: false)

            }
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
}

