//
//  SendPINResponse.swift
//  MFUIAthentication
//
//  Created by Akash Belekar on 06/06/23.
//

import Foundation
import ObjectMapper


//MARK: TAResendPINRequest
public class TAResendPINRequest: Mappable{
    
    var model:AuthSessionIDResponse?
    
    public init() {}
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
         model <- map["model"]
    }
}


//MARK: AuthSessionIDResponse
public class AuthSessionIDResponse:Mappable{
    
    var authSessionId : String = ""
    
    public init() {}
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        authSessionId <- map["authSessionId"]
    }
}
