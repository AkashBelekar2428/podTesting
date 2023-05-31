//
//  TAAuthenticateRequest.swift
//  MFAuthAccess_Example
//
//  Created by Nishu Sharma on 17/05/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//


//{
//  "model": {
//    "clientId": "7f627b8a-d174-4679-bb37-4414afd34ee2",
//    "clientScope": "ottr-api"
//  }
//}


import Foundation
import ObjectMapper


public class TAAuthenticateStartRequest : Mappable
{
    public var model : TAAuthenticateStartModelObj!
    public init() {}
    required public init?(map: Map) {}
    public func mapping(map: Map)
    {
        model   <- map["model"]
    }
    
}

public class TAAuthenticateStartModelObj : Mappable
{
    public var clientId : String = ""
    public var clientScope : String = ""
   
    public init() {}
    required public init?(map: Map) {}
    public func mapping(map: Map)
    {
        clientId          <- map["clientId"]
        clientScope       <- map["clientScope"]
    }
    
}
