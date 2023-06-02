//
//  ViewController.swift
//  MFAuthAccess
//
//  Created by akashbelekar2428 on 05/05/2023.
//  Copyright (c) 2023 akashbelekar2428. All rights reserved.
//

import UIKit
import ObjectMapper
import SVProgressHUD
import MFUIAthentication

class ViewController: UIViewController,TAMultiAuthFactorSuccess {
   
    var middleLayer : MiddleLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let startAuthUrl = "https://ottr.chavadi.com/auth/api/v1/user/startauthentication"
        let authUrl = "https://ottr.chavadi.com/auth/api/v1/user/authenticate"
        
        let service = APIServices.init()
        self.middleLayer = MiddleLayer.init(webservice: service, authenticateUrl: authUrl, startauthenticateUrl: startAuthUrl, controller: self)
        
        let requestModel = TAAuthenticateStartRequest.init()
        
        let model = TAAuthenticateStartModelObj.init()
       // model.clientId = "7f627b8a-d174-4679-bb37-4414afd34ee2"
        model.clientScope = "ottr-apis"
        requestModel.model = model
        
        self.middleLayer?.delegate = self
        self.middleLayer?.InitialAuthetication(startAuthModel: requestModel)
        
        var authEmail = Email_Address()
        authEmail.controller = self
        authEmail.setEmailDefaultThemes()
        authEmail.frame = self.view.bounds
      // self.view.addSubview(authEmail)
        
        var authAuth = AuthenticationLogIn()
        authAuth.controller = self
        authAuth.setDefaultThems()
        authAuth.frame = self.view.bounds
        //self.view.addSubview(authAuth)

        var authPIN = PINView()
        authPIN.controller = self
        authPIN.setPINDefaultThemes()
        authPIN.frame = self.view.bounds
       //self.view.addSubview(authPIN)
        
        var authMob = Mobile_Number()
        authMob.controller = self
        authMob.setMobileDefaultThemes()
        authMob.frame = self.view.bounds
        self.view.addSubview(authMob)
        
        
    }
    
    func TAAuthFactorCompletedWithToken(token: TAAuthGenericResponseTokenObj) {
        print("Auth success with token =====> \(token.token)")
        
        let authSuccess = AuthenticationSuccess.init()
        authSuccess.modalPresentationStyle = .fullScreen
        present(authSuccess, animated: true)
    }
    

}


