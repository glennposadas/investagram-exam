//
//  APIManager.swift
//  LemiTravel
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import Result
import SVProgressHUD

typealias SuccessCallBack = ((_ data: Data) -> Void)?
typealias EmptySuccessCallBack = (() -> (Void))?
typealias ErrorCallBack = ((_ errorMessage: String, _ networkErrorCode: Int, _ llfErrorCode: String) -> Void)?

/// The manager for all API Calls.
class APIManager {
    /// Base class of ```APIManager```.
    class Base {
        static func validateResult(_ result: Result<Response, MoyaError>, onSuccess: SuccessCallBack = nil, onError: ErrorCallBack = nil) {
            SVProgressHUD.dismiss {
                switch result {
                case let .success(moyaResponse):
                    if moyaResponse.statusCode == 200 {
                        onSuccess?(moyaResponse.data)
                        return
                    }
                    
                    // Handle error result
                    let data = moyaResponse.data
                    let errorResult = try? JSONDecoder().decode(ErrorResult.self, from: data)
                    
                    onError?(errorResult?.statusMessage ?? "An error has occured.", moyaResponse.statusCode, "\(errorResult?.statusCode ?? 999)")
                    
                case let .failure(error):
                    onError?("Error: \(error.localizedDescription)", (error as NSError).code, "")
                }
            }
        }
        
        static func request<T>(provider: MoyaProvider<T>, target: MoyaProvider<T>.Target, onSuccess: SuccessCallBack = nil, onError: ErrorCallBack = nil) {
            SVProgressHUD.show(withStatus: "Please wait...")
            provider.request(target) { (result) in
                self.validateResult(result, onSuccess: { (jsonObj) in
                    onSuccess?(jsonObj)
                }, onError: onError)
            }
        }
    }
}



















