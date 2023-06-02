//
//  AuthView.swift
//  Reusable
//
//  Created by Akash Belekar on 26/04/23.
//

import UIKit

//MARK: Protocol AuthenticationLogInDelegate
public protocol AuthenticationLogInDelegate{
    func sendPinBtnAction(email: String, password: String)
}

//MARK: AuthenticationLogIn Class
public class AuthenticationLogIn: UIView{
    
    //MARK: @IBOutlets
    @IBOutlet weak public var viewContainerAuth:UIView!
    @IBOutlet weak public var imgLogo:UIImageView!
    @IBOutlet weak public var lblLogin:UILabel!
    @IBOutlet weak public var lblAuthType:UILabel!
    @IBOutlet weak public var viewAuthType:UIView!
    @IBOutlet weak public var lblEmailIcon:UILabel!
    @IBOutlet weak public var tfEmail:UITextField!
    @IBOutlet weak public var lblEnterValidAuth:UILabel!
    @IBOutlet weak public var lblPassword:UILabel!
    @IBOutlet weak public var viewPassword:UIView!
    @IBOutlet weak public var lblPasswordIcon:UILabel!
    @IBOutlet weak public var tfPassword:UITextField!
    @IBOutlet weak public var btnEyeIcon:UIButton!
    @IBOutlet weak public var lblEnterValidePassword:UILabel!
    @IBOutlet weak public var btnForgotPassword:UIButton!
    @IBOutlet weak public var btnValidate:UIButton!
    @IBOutlet weak public var viewContainerHeight: NSLayoutConstraint!
   
    
    //MARK: Variables
    let nibName = "AuthenticationLogIn"
    public var delegate:AuthenticationLogInDelegate?
    public var authConfig = AuthenticationConfiguration()
    lazy var  alert = AlertManager()
    public weak var controller: UIViewController?
    
    //MARK: System methods
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    //MARK: Custom methods
    func commonInit(){
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        tfEmail.delegate = self
        tfPassword.delegate = self
        self.addSubview(view)
        self.viewContainerAuth.isHidden = true
    }
    
    func loadViewFromNib() -> UIView?{
        let bundel = Bundle(for: AuthenticationLogIn.self)
        let nib = bundel.loadNibNamed(nibName, owner: self)?.first as? UIView
        return nib
    }
    
    //MARK: Lable Configuration for login
    public func setThemsForLoginLabel(lbl:UILabel, config:TALable){
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.numberOfLines = config.TATextNumberOfLines
        lbl.textAlignment = config.TATextAlignment
    }
    
    //MARK: Lable Configuration for Email
    public func setThemsForEmailLabel(lbl:UILabel, config:TALable){
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.textAlignment = config.TATextAlignment
        lbl.numberOfLines = config.TATextNumberOfLines
    }
    
    //MARK: Lable Configuration for Password
    public func setThemsForPasswordLabel(lbl:UILabel, config:TALable){
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.textAlignment = config.TATextAlignment
        lbl.numberOfLines = config.TATextNumberOfLines
    }
    
    
    //MARK: Lable Configuration for Enter Valide Email
    public func setThemsForEnterValidEmailLabel(lbl:UILabel, config:TALable){
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.textAlignment = config.TATextAlignment
        lbl.numberOfLines = config.TATextNumberOfLines
    }
    
    //MARK: Lable Configuration for Enter Valide Email
    public func setThemsForEnterValidPasswordLabel(lbl:UILabel, config:TALable){
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.textAlignment = config.TATextAlignment
        lbl.numberOfLines = config.TATextNumberOfLines
    }
    
    //MARK: View Configuration for tfAuth
    public func setThemsForTfView(view:UIView, config:TAUIView){
        view.layer.cornerRadius = CGFloat(config.TAViewCornerRadius)
        view.layer.borderColor = config.TAviewTfBorderColor.cgColor
        view.layer.borderWidth = CGFloat(config.TAviewborderWidth)
    }
    
    //MARK: TextField
    public func setThemsForTextField(textfiled: UITextField, config:TATextFiled){
        textfiled.placeholder  = config.TATextfiledPlaceHolderText
        textfiled.textColor   = config.TATextfiledPlaceHolderTextColor
        textfiled.font = config.TATextfiledPlaceHolderTextFont
    }
    
    //MARK:  Button Configuration for Forgot Password
    public func setThemsForForgotPasswordButton(btn:UIButton, config: TAButton){
        btn.setTitle(config.TABtnTitleText, for: .normal)
        btn.setTitleColor(config.TABtnTitleTextColor, for: .normal)
        btn.titleLabel?.font = config.TABtnTitleTextFont
        btn.backgroundColor = config.TABtnBackgrounColor
    }
    
    
    //MARK: Validate Button
    public func setThemsForButton(btn:UIButton, config:TAButton){
        btn.setTitle(config.TABtnTitleText, for: .normal)
        btn.setTitleColor(config.TABtnTitleTextColor, for: .normal)
        btn.titleLabel?.font = config.TABtnTitleTextFont
        btn.backgroundColor = config.TABtnBackgrounColor
        btn.layer.cornerRadius = CGFloat(config.TABtnCornerRadius)
        btn.layer.masksToBounds = config.TABtnMasksToBounds
    }
    
    //MARK: ContainerView
    public func setThemsContainerView(view:UIView, config: TAUIView){
        view.layer.shadowColor = config.TAviewShadowColor.cgColor
        view.layer.shadowOpacity = Float(config.TAviewShadowOpacity)
        view.layer.shadowOffset = config.TAviewShadowOffset
        view.layer.shadowRadius = CGFloat(config.TAViewCornerRadius)
        view.layer.cornerRadius = CGFloat(config.TAViewCornerRadius)
        self.viewContainerHeight.constant = CGFloat(config.TAviewHeight)
    }

    //MARK: SetDefaultThems
    public func setDefaultThems(){
        let config = self.themsConfiguration()
        setThemWithAuthConfiguration(config: config)
    }
    
    //MARK: Configure DefaultThems
    func themsConfiguration() -> AuthenticationConfiguration{
        let authConfigObj = AuthenticationConfiguration()
        let lblLogin = TALable()
        let lblAuthType = TALable()
        let lblPassword = TALable()
        let lblEnterValidEmail = TALable()
        let lblEnterValidPassword = TALable()
        let viewTestfiled = TAUIView()
        let tfFirst = TATextFiled()
        let tfSecond = TATextFiled()
        let btnForgotPassword = TAButton()
        let btnValid = TAButton()
        let containerView = TAUIView()
       
        
        //MARK: Config Login Label
        lblLogin.TAText = "Login"
        lblLogin.TATextColor = #colorLiteral(red: 0.07677120715, green: 0.07693774253, blue: 0.0824514851, alpha: 1)
        lblLogin.TATextFont = .boldSystemFont(ofSize: 28)
        lblLogin.TATextAlignment = .left
        lblLogin.TATextNumberOfLines = 0
        
        //MARK: Config Email Label
        lblAuthType.TAText = "Email"
        lblAuthType.TATextColor = #colorLiteral(red: 0.07677120715, green: 0.07693774253, blue: 0.0824514851, alpha: 1)
        lblAuthType.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        lblAuthType.TATextAlignment = .left
        lblAuthType.TATextNumberOfLines = 0
        
        //MARK: Config Password Label
        lblPassword.TAText = "Password"
        lblPassword.TATextColor = #colorLiteral(red: 0.07677120715, green: 0.07693774253, blue: 0.0824514851, alpha: 1)
        lblPassword.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        lblPassword.TATextAlignment = .left
        lblPassword.TATextNumberOfLines = 0
        
        //MARK: Config Enter Valid Email Lebel
        lblEnterValidEmail.TAText = "Please enter valid Eamil"
        lblEnterValidEmail.TATextColor = #colorLiteral(red: 0.8632873893, green: 0.2070690691, blue: 0.2673147619, alpha: 1)
        lblEnterValidEmail.TATextFont = .systemFont(ofSize: 13)
        lblEnterValidEmail.TATextAlignment = .left
        lblEnterValidEmail.TATextNumberOfLines = 0
        
        //MARK: Config Enter Valid Password Lebel
        lblEnterValidPassword.TAText = "Please enter valid Password"
        lblEnterValidPassword.TATextColor = #colorLiteral(red: 0.8632873893, green: 0.2070690691, blue: 0.2673147619, alpha: 1)
        lblEnterValidPassword.TATextFont = .systemFont(ofSize: 13)
        lblEnterValidPassword.TATextAlignment = .left
        lblEnterValidPassword.TATextNumberOfLines = 0
        
        
        //MARK: Config tfView
        viewTestfiled.TAViewCornerRadius = 5
        viewTestfiled.TAviewborderWidth = 1
        viewTestfiled.TAviewTfBorderColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
  
        
        //MARK: Email Textfiled#colorLiteral(red: 0.8417297006, green: 0.8417295814, blue: 0.841729641, alpha: 1)
        tfFirst.TATextfiledPlaceHolderText = "abc@yourdomain.com"
        tfFirst.TATextfiledPlaceHolderTextColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
       
        tfFirst.TATextfiledPlaceHolderTextFont = .systemFont(ofSize: 14, weight: .medium)
        
        //MARK: Password Textfiled
        tfSecond.TATextfiledPlaceHolderText = "********"
        tfSecond.TATextfiledPlaceHolderTextColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        tfSecond.TATextfiledPlaceHolderTextFont = .systemFont(ofSize: 14, weight: .medium)
        
      
        //MARK: ForgotPassword Button
        btnForgotPassword.TABtnTitleText = "Forgot Password?"
        btnForgotPassword.TABtnTitleTextColor = #colorLiteral(red: 0.1019607843, green: 0.05098039216, blue: 0.6705882353, alpha: 1)
        btnForgotPassword.TABtnTitleTextFont = .systemFont(ofSize: 14, weight: .medium)
        btnForgotPassword.TABtnBackgrounColor = .white
        
        
        //MARK: Validate Buttun
        btnValid.TABtnTitleText = "Validate"
        btnValid.TABtnTitleTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnValid.TABtnTitleTextFont = .systemFont(ofSize: 14, weight: .medium)
        btnValid.TABtnBackgrounColor = #colorLiteral(red: 0.2705882353, green: 0.2745098039, blue: 0.3019607843, alpha: 1)
        btnValid.TABtnCornerRadius = 5
        
        
        //MARK: ContainerView
        containerView.TAViewCornerRadius = 20
        containerView.TAviewShadowColor = #colorLiteral(red: 0.8156862745, green: 0.831372549, blue: 0.8666666667, alpha: 1)
        containerView.TAviewShadowOpacity = 0.4
        containerView.TAviewShadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.TAviewShadowRadius = 6
        containerView.TAviewHeight = 500
        
        
        //MARK: Assign Values
        authConfigObj.loginLbl = lblLogin
        authConfigObj.authLbl = lblAuthType
        authConfigObj.passwordLbl = lblPassword
        authConfigObj.enterValidAuthLbl = lblEnterValidEmail
        authConfigObj.enterValidPasswordLBl = lblEnterValidPassword
        authConfigObj.tfView = viewTestfiled
        authConfigObj.firstTextfiled = tfFirst
        authConfigObj.secondTextfiled = tfSecond
        authConfigObj.validBtn = btnValid
        authConfigObj.forgotPasswordBtn = btnForgotPassword
        authConfigObj.containerViewShow = containerView
        
        return authConfigObj
    }
    
    //MARK: Set Configurations
    public func setThemWithAuthConfiguration(config:AuthenticationConfiguration){
        
        self.setThemsForLoginLabel(lbl: lblLogin, config: config.loginLbl)
        
        self.setThemsForEmailLabel(lbl: lblAuthType, config: config.authLbl)
        
        self.setThemsForPasswordLabel(lbl: lblPassword, config: config.passwordLbl)
        
        self.setThemsForEnterValidEmailLabel(lbl: lblEnterValidAuth, config: config.enterValidAuthLbl)
        
        self.setThemsForEnterValidPasswordLabel(lbl: lblEnterValidePassword, config: config.enterValidPasswordLBl)
        
        self.setThemsForTfView(view: viewPassword, config: config.tfView)
        
        self.setThemsForTfView(view: viewAuthType, config: config.tfView)
        
        self.setThemsForTextField(textfiled: tfEmail, config: config.firstTextfiled)
        
        self.setThemsForTextField(textfiled: tfPassword, config: config.secondTextfiled)
        
        self.setThemsForButton(btn: btnForgotPassword, config: config.forgotPasswordBtn)
        
        self.setThemsForButton(btn: btnValidate, config: config.validBtn)
        
        self.setThemsContainerView(view: viewContainerAuth, config: config.containerViewShow)
        
        
        self.viewContainerAuth.isHidden = false
    }
    
    //MARK: IBAction
    @IBAction func validateBtnAction(_ sender:UIButton){
        
        let username = ValidationClass.shared.isUsernameValid(username: tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        let password = ValidationClass.shared.isPasswordValid(password: tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        
        if username.1 == true {
            if password.1 == true{
                delegate?.sendPinBtnAction(email: tfEmail.text!, password: tfPassword.text!)
            }else{
                let topController = TopControllerManager.getTopViewController()
                AlertManager.shared.showAlert(title: App_Alert_Title, msg: password.0, action: ok, viewController: topController!)
            }
        }else{
            let topController = TopControllerManager.getTopViewController()
            AlertManager.shared.showAlert(title: App_Alert_Title, msg:username.0 , action: ok, viewController: topController!)
        }
    }
    
    @IBAction func eyeBtnAction(){
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
        //        let btneyeImg = tfPassword.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        //        btnEye.setImage(btneyeImg, for: .normal)
    }

    @IBAction func forgotPasswordBtnAction(){
        
    }
}

//MARK: UITextFieldDelegate Extension
extension AuthenticationLogIn:UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}


