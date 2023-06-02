//
//  EmailView.swift
//  Reusable
//
//  Created by Akash Belekar on 27/04/23.
//

import UIKit

//MARK: Protocol EmailAddressDelegate
public protocol EmailAddressDelegate{
    func sendPINBtnAction(email:String)
}

//MARK: Email_Address Class
public class Email_Address: UIView{
    
    //MARK: Outlets
    @IBOutlet weak public var viewContainerEmail:UIView!
    @IBOutlet weak public var imgLogo:UIImageView!
    @IBOutlet weak public var lblLogin:UILabel!
    @IBOutlet weak public var lblEmail:UILabel!
    @IBOutlet weak public var viewTfEmail:UIView!
    @IBOutlet weak public var lblEmailIcon:UILabel!
    @IBOutlet weak public var tfEmail:UITextField!
    @IBOutlet weak public var lblEnterValideEmail:UILabel!
    @IBOutlet weak public var btnValid:UIButton!
   
    @IBOutlet weak public var viewContainerHeight: NSLayoutConstraint!

    //MARK: Variables
    let nibName = "Email_Address"
    public var pinViewIns = PINView()
    public var delegate:EmailAddressDelegate?
    public var emailConfig = AuthenticationConfiguration()
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
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        tfEmail.delegate = self
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView?{
        let bundel = Bundle(for: Email_Address.self)
        let nib = bundel.loadNibNamed(nibName, owner: self)?.first as? UIView
        return nib
    }
    
    //MARK: lables
    public func setThemsForLable(lbl:UILabel, config:TALable){
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.numberOfLines = config.TATextNumberOfLines
        lbl.textAlignment = config.TATextAlignment
    }
    
    
    //MARK: tfview
    public func setThemsForTextFieldView(view:UIView, config:TAUIView){
        view.layer.cornerRadius = CGFloat(config.TAViewCornerRadius)
        view.layer.borderWidth = CGFloat(config.TAviewborderWidth)
        view.layer.borderColor = config.TAviewTfBorderColor.cgColor
    }
    
    //MARK: TextField
    public func setThemsForTextField(textfiled: UITextField, config:TATextFiled){
        textfiled.placeholder = config.TATextfiledPlaceHolderText
        textfiled.textColor = config.TATextfiledPlaceHolderTextColor
        textfiled.font = config.TATextfiledPlaceHolderTextFont
        textfiled.layer.borderColor = config.TATextfiledPlaceHolderBorderColor.cgColor
        textfiled.layer.borderWidth = CGFloat(config.TATextfiledPlaceHolderBorderWidth)
        textfiled.layer.cornerRadius = CGFloat(config.TATextfiledPlaceHolderCornerRadius)
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
    
    //MARK: HeaderView Logo
    public func setThemsForHeaderViewImageORLogo(img: UIImageView, config: TAImage){
        img.image = config.TAImageLogo
    }
    
    //MARK: SetDefaultThems
    public func setEmailDefaultThemes(){
        let configObj = themsConfiguration()
        self.setThemeWithEmailConfiguration(config: configObj)
    }
    
    //MARK: Configure DefaultThems
    func themsConfiguration() -> AuthenticationConfiguration{
        let config = AuthenticationConfiguration()
        let containerView = TAUIView()
        let imgLogo = TAImage()
        let lblLogin = TALable()
        let lblEmail = TALable()
        let tfView = TAUIView()
        let textField = TATextFiled()
        let lblEnterEmailValid = TALable()
        let btnValid = TAButton()
       
   
        //MARK: ContainerView
        containerView.TAViewCornerRadius = 10
        containerView.TAviewShadowColor = .gray
        containerView.TAviewShadowOpacity = 0.4
        containerView.TAviewShadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.TAviewShadowRadius = 6
        containerView.TAviewHeight = 350
        
        //MARK: Header Img Logo
        imgLogo.TAImageLogo = UIImage(named: "\("logo2")") ?? UIImage()
        
        //MARK: Configuration for Login
        lblLogin.TAText = "Login"
        lblLogin.TATextColor = #colorLiteral(red: 0.09790506214, green: 0.09823218733, blue: 0.10885299, alpha: 1)
        lblLogin.TATextAlignment = .left
        lblLogin.TATextFont = .boldSystemFont(ofSize: 28)
        
        //MARK: Txt
        lblEmail.TAText = "Email"
        lblEmail.TATextColor = #colorLiteral(red: 0.09790506214, green: 0.09823218733, blue: 0.10885299, alpha: 1)
        lblEmail.TATextAlignment = .left
        lblEmail.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        
        
        //MARK: View textfiled
        tfView.TAViewCornerRadius = 5
        tfView.TAviewborderWidth = 1
        tfView.TAviewTfBorderColor = #colorLiteral(red: 0.6399982572, green: 0.6399982572, blue: 0.6399982572, alpha: 1)
        
        
        //MARK:  Textfiled
        textField.TATextfiledPlaceHolderText = "abc@yourdomain.com"
        textField.TATextfiledPlaceHolderTextColor = #colorLiteral(red: 0.7176470588, green: 0.7333333333, blue: 0.7490196078, alpha: 1)
        textField.TATextfiledPlaceHolderTextFont = .systemFont(ofSize: 14, weight: .medium)
        
        //MARK: Enter Valid Email
        lblEnterEmailValid.TAText = "Please enter valid Email"
        lblEnterEmailValid.TATextColor = #colorLiteral(red: 0.8632873893, green: 0.2070690691, blue: 0.2673147619, alpha: 1)
        lblEnterEmailValid.TATextAlignment = .left
        lblEnterEmailValid.TATextFont = .systemFont(ofSize: 14, weight: .regular)
        
        //MARK: valide Btn
        btnValid.TABtnTitleText = "Validate"
        btnValid.TABtnTitleTextColor = .white
        btnValid.TABtnBackgrounColor = #colorLiteral(red: 0.2683097124, green: 0.2734355927, blue: 0.300306946, alpha: 1)
        btnValid.TABtnTitleTextFont = .systemFont(ofSize: 14, weight: .medium)
        btnValid.TABtnCornerRadius = 5
        btnValid.TABtnMasksToBounds =  true
        
        //MARK: Assign Values
        config.containerViewShow = containerView
        config.logoImage = imgLogo
        config.loginLbl = lblLogin
        config.emailLbl = lblEmail
        config.tfView = tfView
        config.firstTextfiled = textField
        config.enterValidEmail = lblEnterEmailValid
        config.validBtn = btnValid
        

        return config
    }
    
    //MARK: Set Configurations
    public func setThemeWithEmailConfiguration(config:AuthenticationConfiguration){
        
       // self.setThemsContainerView(view: viewContainerEmail, config: config.containerViewShow)
        
        self.setThemsForHeaderViewImageORLogo(img: imgLogo, config: config.logoImage)
        
        self.setThemsForLable(lbl: lblLogin, config: config.loginLbl)
        
        self.setThemsForLable(lbl: lblEmail, config: config.emailLbl)
        
        self.setThemsForTextFieldView(view: viewTfEmail, config: config.tfView)
        
        self.setThemsForTextField(textfiled: tfEmail, config: config.firstTextfiled)
        
        self.setThemsForLable(lbl: lblEnterValideEmail, config: config.enterValidEmail)
        
        self.setThemsForButton(btn: btnValid, config: config.validBtn)
        
        
        
        
    }
    
    //MARK: IBAction
    @IBAction func validBtnACtion(_ sender:UIButton){
 
        let emailValid = self.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = ValidationClass.shared.isEmailValid(email: emailValid)
        
        if email.1 == true {
            delegate?.sendPINBtnAction(email: tfEmail.text!)
            
        }else{
            let topController = TopControllerManager.getTopViewController()
            alert.showAlert(title: App_Alert_Title, msg:email.0, action: ok, viewController: topController!)
        }
    }
}

//MARK: UITextFieldDelegate Extension
extension Email_Address:UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




