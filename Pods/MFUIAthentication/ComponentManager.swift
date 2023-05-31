//
//  ComponentManager.swift
//  MFUIAthentication
//
//  Created by Akash Belekar on 30/05/23.
//

import Foundation

public protocol ComponentManagerDelegate{
    func sendPinBtnAction(email: String, password: String)
    func sendPINBtnAction(email:String)
    func sendPINAction(mobileNumber:String)
    func validateBtnAction(pinNumber: String)
}

public class ComponentManager{
    
    //MARK: Singletone
     public init() {}
    
    private var enum_authType: TAAuthFactorType = .NONE
    private var enum_nextStep: TAAuthFactorNextStep = .NONE
    private var enum_componentType: TAAuthFactorType = .NONE
    
    public var delegate : ComponentManagerDelegate?
    
    public var tagForComponent : Int {
        get {
            return 4444
        }
    }
    
    public func configureComponentFactorwise(nextStep:Int, authFactor:Int) -> UIView? {
        
        SetAuthNextStep(nextStep: nextStep)
        SetAuthFactorType(authFactor: authFactor)
        SetComponentType(authFactor: self.enum_authType, nextStep: self.enum_nextStep)
        
         return ConfigureUI(type: self.enum_componentType)
    }
    
    private func SetAuthFactorType(authFactor : Int) {
        if authFactor == 1 {
            enum_authType = .USERNAME_PASSWORD
        } else if authFactor == 2 {
            enum_authType = .EMAIL_PASSWORD
        } else if authFactor == 3 {
            enum_authType = .MOBILE_PIN
        } else if authFactor == 4 {
            enum_authType = .EMAIL_PIN
        } else {
            enum_authType = .NONE
        }
    }
    
    
    private func SetAuthNextStep(nextStep : Int) {
       
        if nextStep == 1 {
            enum_nextStep = .VERIFY_USERNAME_PASSWORD
        } else if nextStep == 2 {
            enum_nextStep = .VERIFY_EMAIL_PASSWORD
        } else if nextStep == 3 {
            enum_nextStep = .VERIFY_PASSWORD
        } else if nextStep == 4 {
            enum_nextStep = .VERIFIY_PHONENUMBER
        } else if nextStep == 5 {
            enum_nextStep = .VERIFY_PIN
        } else if nextStep == 6 {
            enum_nextStep = .VERIFY_EMAIL
        } else if nextStep == 99 {
            enum_nextStep = .AUTH_COMPLETE
        } else {
            enum_nextStep = .NONE
        }
    }
    
    
    private func SetComponentType(authFactor :TAAuthFactorType ,nextStep: TAAuthFactorNextStep)
    {
        if authFactor == .USERNAME_PASSWORD {
            if nextStep == .VERIFY_USERNAME_PASSWORD || nextStep == .VERIFY_PASSWORD {
                enum_componentType = .USERNAME_PASSWORD
            } else if nextStep == .VERIFY_PIN {
                enum_componentType = .SIXDIGITPIN
            } else {
                enum_componentType = .NONE
            }
        } else if authFactor == .EMAIL_PASSWORD {
            if nextStep == .VERIFY_EMAIL_PASSWORD || nextStep == .VERIFY_PASSWORD {
                enum_componentType = .EMAIL_PASSWORD
            } else if nextStep == .VERIFY_PIN {
                enum_componentType = .SIXDIGITPIN
            } else {
                enum_componentType = .NONE
            }
        } else if authFactor == .MOBILE_PIN {
            if nextStep == .VERIFIY_PHONENUMBER {
                enum_componentType = .MOBILE_PIN
            } else if nextStep == .VERIFY_PIN {
                enum_componentType = .SIXDIGITPIN
            } else {
                enum_componentType = .NONE
            }
        } else if authFactor == .EMAIL_PIN {
            if nextStep == .VERIFY_EMAIL {
                enum_componentType = .EMAIL_PIN
            } else if nextStep == .VERIFY_PIN {
                enum_componentType = .SIXDIGITPIN
            } else {
                enum_componentType = .NONE
            }
        } else {
            enum_componentType = .NONE
        }
    }
    
    private func ConfigureUI(type : TAAuthFactorType) -> UIView? {

        if type == .USERNAME_PASSWORD || type == .EMAIL_PASSWORD
        {
            var view : UIView {
                get {
                    let UsernamePasswordUI = AuthenticationLogIn()
//                    UsernamePasswordUI.frame = frame
                    UsernamePasswordUI.tag = self.tagForComponent
                    UsernamePasswordUI.delegate = self
                    UsernamePasswordUI.setDefaultThems()
//                    UsernamePasswordUI.controller = self.controller
                    return UsernamePasswordUI
                }
            }
            return view
        }
        else
        if type == .EMAIL_PIN
        {
            var view : UIView {
                get {
                    let emailPasswordUI = Email_Address()
//                    emailPasswordUI.frame = frame
                    emailPasswordUI.setEmailDefaultThemes()
                    emailPasswordUI.tag = self.tagForComponent
                    emailPasswordUI.delegate = self
//                    emailPasswordUI.controller = self.controller
                    return emailPasswordUI
                }
            }
            return view
        }
        else
        if type == .SIXDIGITPIN
        {
            var view : UIView {
                get {
                    let pinUI = PINView()
//                    pinUI.frame = frame
                    pinUI.tag = self.tagForComponent
                    pinUI.setPINDefaultThemes()
                    pinUI.delegate = self
//                    pinUI.controller = self.controller
                    return pinUI
                }
            }
            return view
        }
        else
        if type == .MOBILE_PIN
        {
            var view : UIView {
                get {
                    let MobileUI = Mobile_Number()
//                    MobileUI.frame = frame
                    MobileUI.tag = self.tagForComponent
                    MobileUI.setMobileDefaultThemes()
                    MobileUI.delegate = self
//                    MobileUI.controller = self.controller
                    return MobileUI
                }
            }
            return view
        }
        else
        {
            return UIView()
        }
    }
    
}

extension ComponentManager : AuthenticationLogInDelegate {
    public func sendPinBtnAction(email: String, password: String) {
        delegate?.sendPinBtnAction(email: email, password: password)
    }
}

extension ComponentManager : EmailAddressDelegate{
    public func sendPINBtnAction(email: String) {
        delegate?.sendPINBtnAction(email: email)
    }
}

extension ComponentManager : PINViewDelegate{
    public func validateBtnAction(pinNumber: String) {
        delegate?.validateBtnAction(pinNumber: pinNumber)
    }
}

extension ComponentManager : MobileNumberDelegate{
    public func sendPINAction(mobileNumber: String) {
        delegate?.sendPINAction(mobileNumber: mobileNumber)
    }
}
