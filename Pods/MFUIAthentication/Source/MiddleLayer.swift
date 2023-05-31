//
//  MiddleLayer.swift
//  MFAuthAccess_Example
//
//  Created by Nishu Sharma on 18/05/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//


import Foundation
import UIKit
import ObjectMapper
import SVProgressHUD

//MARK: TAMultiAuthFactorSuccess Protocol
public protocol TAMultiAuthFactorSuccess : AnyObject {
    func TAAuthFactorCompletedWithToken(token: TAAuthGenericResponseTokenObj)
}

//MARK: Class MiddleLayer
public class MiddleLayer : TAAuthProtocols {
    
    //MARK: Variables
    var webservice : WsHelperProtocol!
    var authenticateUrl : String = ""
    var startauthenticateUrl : String = ""
    var TAAuthRespObj : TAAuthGenericResponse?
    var controller : UIViewController?
    private var startAuthModel : TAAuthenticateStartRequest?
    private var genericAuthRequest : TAAuthenticateRequest?
    
    public weak var delegate : TAMultiAuthFactorSuccess?
    
    //MARK: Tag
    private var tagForComponent : Int {
        get {
            return 4444
        }
    }
    
    //MARK: init
    required public init(webservice: WsHelperProtocol, authenticateUrl : String, startauthenticateUrl : String, controller : UIViewController) {
        self.webservice = webservice
        self.authenticateUrl = authenticateUrl
        self.startauthenticateUrl = startauthenticateUrl
        self.controller = controller
        
    }
    
    //MARK: InitialAuthetication Method
    public func InitialAuthetication(startAuthModel : TAAuthenticateStartRequest) {
        showLoader()
        self.startAuthModel = startAuthModel
        self.webservice.GetSessionIdForAuthetication(api: self.startauthenticateUrl, requestModel: startAuthModel) { resp in
            self.ResponseManager(resp: resp, isCallAutheticate: false)
        }
    }
    
    //MARK: NExtFactorAuthentication Method
    public func StartNextFactorAuthentoicationProcess(RequestModel:TAAuthenticateRequest) {
        showLoader()
        self.genericAuthRequest = RequestModel
        self.webservice.Authenticate(api: self.authenticateUrl, requestModel: RequestModel) { resp in
            self.ResponseManager(resp: resp, isCallAutheticate: true)
        }
    }
    
    //MARK: ResponseManager Method
    private func ResponseManager(resp : GeneralRespModel?, isCallAutheticate : Bool) {
        
        if resp?.status == true {
            if let genericResp = resp?.respObj as? TAAuthGenericResponse {
                if genericResp.isError == false {
                    if genericResp.data != nil {
                        self.TAAuthRespObj = genericResp
                        self.ConfigureTypesAndSetComponent()
                    } else{
                        AlertManager.shared.showAlert(title: "Alert", msg: "No data found.", action: "OK", viewController: self.controller ?? UIViewController())
                        hideLoader()
                    }
                }else {
                    // show alert with errorMessage
                    AlertManager.shared.showAlert(title: "Alert", msg: genericResp.errorMessage, action: "OK", viewController: self.controller ?? UIViewController())
                    hideLoader()
                }
            }
        }  else  {
            if resp?.etype == .ServerError {
                // show server error message
                AlertManager.shared.showAlert(title: "Alert", msg: resp?.message ?? somethngWentWrng_Msg, action: "OK", viewController: self.controller ?? UIViewController())
            }
            else
            if resp?.etype == .sessionTimeOut {
                AlertManager.shared.showAlert(title: "Alert", msg: "Session timeout !!", action: "OK", viewController: self.controller ?? UIViewController())
                // navigate to first page
                self.InitialAuthetication(startAuthModel: self.startAuthModel!)
            }  else
            if resp?.etype == .NoInternet {
                AlertManager.shared.showAlertsActions(title: "Alert", msg: "No internet connection !!", firstAction: "Retry", secondAction: "Cancel", firstCompletion: {
                    if isCallAutheticate == true {
                        self.StartNextFactorAuthentoicationProcess(RequestModel: self.genericAuthRequest!)
                    } else {
                        self.InitialAuthetication(startAuthModel: self.startAuthModel!)
                    }
                    
                }, secondCompletion: {
                    
                }, viewController: self.controller!)
            }
            hideLoader()
        }
    }
    
    //MARK: ConfigureTypesAndSetComponent
    private func ConfigureTypesAndSetComponent() {
        let dataObj = self.TAAuthRespObj?.data
        
        self.SetAuthFactorType(authFactor: (self.TAAuthRespObj?.data.nextAuthFactor) ?? 0)
        self.SetAuthNextStep(nextStep: (self.TAAuthRespObj?.data.nextStep) ?? 0)
        self.SetComponentType(authFactor: dataObj!.authType, nextStep: dataObj!.nextStepEnum)
        
        print("Factor ==> \(String(describing: self.TAAuthRespObj?.data.nextStepEnum))")
        print("Type ==> \(String(describing: self.TAAuthRespObj?.data.authType))")
        
        if self.TAAuthRespObj?.data.nextStepEnum == .AUTH_COMPLETE {
            if self.TAAuthRespObj?.data.token != nil {
                hideLoader()
                self.delegate?.TAAuthFactorCompletedWithToken(token: (self.TAAuthRespObj?.data.token)!)
            } else {
                self.InitialAuthetication(startAuthModel: self.startAuthModel!)
            }
        } else {
            self.AddComponentFactorWise()
        }
    }
    
    //MARK: AddComponentFactorWise
    private func AddComponentFactorWise() {
        let type = self.TAAuthRespObj?.data.componentType ?? .NONE
        if let view = self.ConfigureUI(type: type) {
            if let controller = controller {
                controller.view.addSubview(view)
            }
        }
        hideLoader()
    }
    
    //MARK: Enum-Configurations AuthFactorType
    private func SetAuthFactorType(authFactor : Int) {
        let obj = self.TAAuthRespObj?.data
        if authFactor == 1 {
            obj?.authType = .USERNAME_PASSWORD
        } else if authFactor == 2 {
            obj?.authType = .EMAIL_PASSWORD
        } else if authFactor == 3 {
            obj?.authType = .MOBILE_PIN
        } else if authFactor == 4 {
            obj?.authType = .EMAIL_PIN
        } else {
            obj?.authType = .NONE
        }
    }
    
    //MARK: Enum-Configurations AuthNextStep
    private func SetAuthNextStep(nextStep : Int) {
        let obj = self.TAAuthRespObj?.data
        if nextStep == 1 {
            obj?.nextStepEnum = .VERIFY_USERNAME_PASSWORD
        } else if nextStep == 2 {
            obj?.nextStepEnum = .VERIFY_EMAIL_PASSWORD
        } else if nextStep == 3 {
            obj?.nextStepEnum = .VERIFY_PASSWORD
        } else if nextStep == 4 {
            obj?.nextStepEnum = .VERIFIY_PHONENUMBER
        } else if nextStep == 5 {
            obj?.nextStepEnum = .VERIFY_PIN
        } else if nextStep == 6 {
            obj?.nextStepEnum = .VERIFY_EMAIL
        } else if nextStep == 99 {
            obj?.nextStepEnum = .AUTH_COMPLETE
        } else {
            obj?.nextStepEnum = .NONE
        }
    }
    
    //MARK: Configurations ComponentType
    private func SetComponentType(authFactor :TAAuthFactorType ,nextStep: TAAuthFactorNextStep){
        if authFactor == .USERNAME_PASSWORD {
            if nextStep == .VERIFY_USERNAME_PASSWORD || nextStep == .VERIFY_PASSWORD {
                self.TAAuthRespObj?.data.componentType = .USERNAME_PASSWORD
            } else if nextStep == .VERIFY_PIN {
                self.TAAuthRespObj?.data.componentType = .SIXDIGITPIN
            } else {
                self.TAAuthRespObj?.data.componentType = .NONE
            }
        } else if authFactor == .EMAIL_PASSWORD {
            if nextStep == .VERIFY_EMAIL_PASSWORD || nextStep == .VERIFY_PASSWORD {
                self.TAAuthRespObj?.data.componentType = .EMAIL_PASSWORD
            } else if nextStep == .VERIFY_PIN {
                self.TAAuthRespObj?.data.componentType = .SIXDIGITPIN
            } else {
                self.TAAuthRespObj?.data.componentType = .NONE
            }
        } else if authFactor == .MOBILE_PIN {
            if nextStep == .VERIFIY_PHONENUMBER {
                self.TAAuthRespObj?.data.componentType = .MOBILE_PIN
            } else if nextStep == .VERIFY_PIN {
                self.TAAuthRespObj?.data.componentType = .SIXDIGITPIN
            } else {
                self.TAAuthRespObj?.data.componentType = .NONE
            }
        } else if authFactor == .EMAIL_PIN {
            if nextStep == .VERIFY_EMAIL {
                self.TAAuthRespObj?.data.componentType = .EMAIL_PIN
            } else if nextStep == .VERIFY_PIN {
                self.TAAuthRespObj?.data.componentType = .SIXDIGITPIN
            } else {
                self.TAAuthRespObj?.data.componentType = .NONE
            }
        } else {
            self.TAAuthRespObj?.data.componentType = .NONE
        }
    }
    
    //MARK: ConfigureUI
    private func ConfigureUI(type : TAAuthFactorType) -> UIView? {
        
        if let taggedView = self.controller?.view.viewWithTag(self.tagForComponent) {
            taggedView.removeFromSuperview()
        }
        
        let compManager = ComponentManager.init(delegate: self)
        
        let nextStep = (self.TAAuthRespObj?.data.nextStep)!
        let factor = (self.TAAuthRespObj?.data.nextAuthFactor)!
        let viewfactorwise = compManager.configureComponentFactorwise(nextStep: nextStep, authFactor: factor)
        viewfactorwise?.tag = self.tagForComponent
        viewfactorwise?.frame = (self.controller?.view.frame)!
        
        return viewfactorwise
    }
    
    func showLoader(){
        SVProgressHUD.show()
        self.controller?.view.isUserInteractionEnabled = false
    }
    
    func hideLoader(){
        SVProgressHUD.dismiss()
        self.controller?.view.isUserInteractionEnabled = true
    }
}

//MARK:  MiddleLayer Extension
extension MiddleLayer : ComponentManagerDelegate {
    
    //MARK: Set ComponentManagerDelegate
    public func sendPinBtnAction(email: String, password: String) {
        print("EMAIL ==> \(email)")
        print("PASSWORD ==> \(password)")
        
        let dataObj = TAAuthRespObj?.data
        
        let isUserNamePasswordComp = dataObj?.componentType == .USERNAME_PASSWORD
        
        let requestObj = TAAuthenticateRequest.init()
        let modelObj = TAAuthenticateRequestModelObj.init()
        modelObj.password = password
        modelObj.email = isUserNamePasswordComp == true ? "" : email
        modelObj.userName = isUserNamePasswordComp == true ? email : ""
        modelObj.authFactorType = dataObj!.nextAuthFactor
        modelObj.currentAuthStep = dataObj!.nextStep
        modelObj.authSessionId = dataObj!.sessionId
        requestObj.model = modelObj
        self.StartNextFactorAuthentoicationProcess(RequestModel: requestObj)
    }
    
    public func sendPINBtnAction(email: String) {
        print("EMAIL ID ==> \(email)")
        let dataObj = TAAuthRespObj?.data
        let requestObj = TAAuthenticateRequest.init()
        let modelObj = TAAuthenticateRequestModelObj.init()
        modelObj.email = email
        modelObj.authFactorType = dataObj!.nextAuthFactor
        modelObj.currentAuthStep = dataObj!.nextStep
        modelObj.authSessionId = dataObj!.sessionId
        requestObj.model = modelObj
        self.StartNextFactorAuthentoicationProcess(RequestModel: requestObj)
    }
    
    public func sendPINAction(mobileNumber: String) {
        print("PHONE NUMBER ==> \(mobileNumber)")
        
        let dataObj = TAAuthRespObj?.data
        let requestObj = TAAuthenticateRequest.init()
        let modelObj = TAAuthenticateRequestModelObj.init()
        modelObj.phoneNumber = "91\(mobileNumber)"
        modelObj.authFactorType = dataObj!.nextAuthFactor
        modelObj.currentAuthStep = dataObj!.nextStep
        modelObj.authSessionId = dataObj!.sessionId
        requestObj.model = modelObj
        self.StartNextFactorAuthentoicationProcess(RequestModel: requestObj)
    }
    
    public func validateBtnAction(pinNumber: String) {
        print("PING VIEW ==> \(pinNumber)")
        let dataObj = TAAuthRespObj?.data
        let requestObj = TAAuthenticateRequest.init()
        let modelObj = TAAuthenticateRequestModelObj.init()
        modelObj.pin = pinNumber
        modelObj.authFactorType = dataObj!.nextAuthFactor
        modelObj.currentAuthStep = dataObj!.nextStep
        modelObj.authSessionId = dataObj!.sessionId
        requestObj.model = modelObj
        self.StartNextFactorAuthentoicationProcess(RequestModel: requestObj)
    }
}
