//
//  MVDefaultsSpec.swift
//  MovieeeTests
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

@testable import Movieee
import Foundation
import Quick
import Nimble

class MVDefaultsSpec: QuickSpec {
    override func spec() {
        describe("Tests for MVDefaults") {

            context("Tests the whole MVDefaults.") {
                
                it("tests the store and retrieve function for any Codable object") {
                    
                    let data = stubbedResponse("MovieResult")
                    expect(data).notTo(beNil())
                    let newMovieResult = try? JSONDecoder().decode(MovieResult.self, from: data!)
                    
                    MVDefaults.store(newMovieResult, key: .someOtherKey)
                    
                    let retrievedObject = MVDefaults.getObjectWithKey(.someOtherKey, type: MovieResult.self)
                    
                    // Assert
                    expect(retrievedObject).notTo(beNil())
                    
                    // Assert
                    expect(retrievedObject?.movies?.first?.id).to(equal(newMovieResult?.movies?.first?.id))
                }
                
                it("tests the store and retrieve function for String") {
                    
                    let string = "Ich bin ein Berliner"
                    
                    MVDefaults.store(string, key: .someOtherKey)
                    
                    let retrievedObject = MVDefaults.getObjectWithKey(.someOtherKey, type: String.self)
                    
                    // Assert
                    expect(retrievedObject).notTo(beNil())
                    
                    // Assert
                    expect(retrievedObject).to(equal(string))
                }
                
                it("tests the removal function") {
                    
                    MVDefaults.removeDefaultsWithKey(.someOtherKey)
                    
                    let anyRetrievedObject = UserDefaults.standard.object(forKey: MVDefaultsKey.someOtherKey.rawValue)
                    let stringRetrievedObject = MVDefaults.getObjectWithKey(.someOtherKey, type: String.self)
                    
                    // Assert
                    expect(anyRetrievedObject).to(beNil())
                    
                    // Assert
                    expect(stringRetrievedObject).to(beNil())
                }
                
                it("tests the store and retrieve function for Boool") {
                    
                    let someBool: Bool = true
                    
                    MVDefaults.store(someBool, key: .someOtherKey)
                    
                    let retrievedObject = MVDefaults.getObjectWithKey(.someOtherKey, type: Bool.self)
                    
                    // Assert
                    expect(retrievedObject).notTo(beNil())
                    
                    // Assert
                    expect(retrievedObject).to(equal(someBool))
                }
            }
        }
    }
}



