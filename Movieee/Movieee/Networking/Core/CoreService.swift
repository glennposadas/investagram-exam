//
//  CoreService.swift
//  LemiTravel
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Moya

public let deviceId = UIDevice.current.identifierForVendor!.uuidString

public let baseURLStringDEV = "https://lemi.travel"
public let apiVersionDEV = "/api/v5"

/// Returns the base url of the API based on the LLFEnv.
public var baseURLString: String {
    get {
        return "\(baseURLStringDEV)\(apiVersionDEV)"
    }
}

/// Helper function
public func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

/// Moya Manager
let moyaManager = Manager(
    configuration: URLSessionConfiguration.default,
    serverTrustPolicyManager: CustomServerTrustPoliceManager()
)

/// The core class of LLF networking
/// The constants for networking is stored in the file ```CoreService.swift```.
class CoreService {
    
    /// Determines if each managers call the API verbosely.
    static var verbose: Bool = false
    
    /// Generates a bearer token.
    class func getBearerToken() -> String? {
        return ""
    }
    
    /// Generates required headers for all API endpoints.
    class func getHeaders() -> [String : String] {
        return [
            "Content-type"  : "application/json",
        ]
    }
}

