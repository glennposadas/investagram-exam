//
//  CustomServerTrustPoliceManager.swift
//  LalaFood
//
//  Created by Glenn Von C. Posadas on 28/08/2018.
//  Copyright © 2018 LalaFood. All rights reserved.
//

import Alamofire
import Foundation

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}
