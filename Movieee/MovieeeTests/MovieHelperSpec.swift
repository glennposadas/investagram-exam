//
//  MovieHelperSpec.swift
//  MovieeeTests
//
//  Created by Glenn Von C. Posadas on 01/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

@testable import Movieee
import Quick
import Nimble

class MovieeeSpec: QuickSpec {
    override func spec() {
        describe("Tests for MovieHelper") {

            var movieResult: MovieResult?
            
            beforeEach {
                let data = stubbedResponse("MovieResult")
                expect(data).notTo(beNil())
                let newMovieResult = try? JSONDecoder().decode(MovieResult.self, from: data!)
                movieResult = newMovieResult
            }
            
            context("Tests the whole MovieHelper.") {
                
                it("tests the release date presentable of the first index movie object.") {
                    
                    let movie = movieResult?.movies?.first
                    
                    // Assert
                    expect(movie).notTo(beNil())
                    
                    // Assert
                    expect {
                        movie?.releaseDatePresentable
                        }.to(equal("March 6, 2019"))
                }
            }
        }
    }
}



