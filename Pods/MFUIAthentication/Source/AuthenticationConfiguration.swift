//
//  AuthenticationConfiguration.swift
//  MFAuthAccess
//
//  Created by Akash Belekar on 09/05/23.
//

import Foundation

//MARK: AuthenticationConfiguration class
public class AuthenticationConfiguration{
    
    //MARK: Variables
    public var headerLbl = TALable()
    public var firstLbl = TALable()
    public var secondLbl = TALable()
    public var firstTextfiled = TATextFiled()
    public var secondTextfiled = TATextFiled()
    public var valideBtn = TAButton()
    public var resendPINBtn = TAButton()
    public var headerView = TAUIView()
    public var logoImage = TAImage()
    public var containerViewShow = TAUIView()
    public var tfView = TAUIView()
    public var countryCodeBtn = TAButton()

    public var viewType: AuthType = .none
    
    public init() {}
}

//MARK: AuthType Enum
public enum AuthType {
    case pinView, email, mobile, authLog, none
    
}

