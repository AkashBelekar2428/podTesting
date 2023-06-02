//
//  MobilePinView.swift
//  Reusable
//
//  Created by Akash Belekar on 27/04/23.
//


import UIKit
import Foundation

//MARK: Protocol MobileNumberDelegate
public protocol MobileNumberDelegate{
    func sendPINAction(mobileNumber:String)
}
public class Mobile_Number:UIView {
    
    //MARK: IBOutlets
    @IBOutlet weak public var viewContainerMobile:UIView!
    @IBOutlet weak public var imgLogo:UIImageView!
    @IBOutlet weak public var lblLogin:UILabel!
    @IBOutlet weak public var lblMobile:UILabel!
    @IBOutlet weak public var lblCountryCode:UILabel!
    @IBOutlet weak public var lblIconCountryCode:UILabel!
    @IBOutlet weak public var viewTfMobileNumber:UIView!
    @IBOutlet weak public var viewCountryCode:UIView!
    @IBOutlet weak public var tfMobileNumber:UITextField!
    @IBOutlet weak public var lblEnterValidMobNum:UILabel!
    @IBOutlet weak public var btnValidate:UIButton!
    @IBOutlet weak public var viewContainerHeight: NSLayoutConstraint!
    
    //MARK: Variables
    let nibName = "Mobile_Number"
    public var delegate:MobileNumberDelegate?
    public var mobileConfig = AuthenticationConfiguration()
    lazy var  alert = AlertManager()
    public weak var controller: UIViewController?
    let pickerView = UIPickerView()
    
    //MARK: System methods
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    
    //MARK: lables
    public func setThemsForLable(lbl:UILabel, config:TALable) {
        lbl.text = config.TAText
        lbl.textColor = config.TATextColor
        lbl.font = config.TATextFont
        lbl.numberOfLines = config.TATextNumberOfLines
        lbl.textAlignment = config.TATextAlignment
        lbl.layer.cornerRadius = CGFloat(config.TATextCornerRadius)
        lbl.layer.borderColor = config.TATextBorderColor.cgColor
        lbl.layer.borderWidth = config.TATextBorderWidth
    }
    
    
    //MARK: View
    public func setThemsForView(view:UIView, config:TAUIView){
        view.layer.borderColor = config.TAviewTfBorderColor.cgColor
        view.layer.cornerRadius = CGFloat(config.TAViewCornerRadius)
        view.layer.borderWidth = CGFloat(config.TAviewborderWidth)
        
    }
    
    //MARK: Country Code Button
    public func setThemsForCountryCodeButton(btn:UIButton, config:TAButton){
        btn.setTitle(config.TABtnTitleText, for: .normal)
        btn.setTitleColor(config.TABtnTitleTextColor, for: .normal)
        btn.layer.cornerRadius = CGFloat(config.TABtnCornerRadius)
        btn.layer.borderColor = config.TABtnBorderColor.cgColor
        btn.layer.borderWidth = CGFloat(config.TABtnBorderWidth)
    }
    
    
    //MARK: TextField
    public func setThemsForTextField(textfiled: UITextField, config:TATextFiled){
        textfiled.placeholder  = config.TATextfiledPlaceHolderText
        textfiled.textColor   = config.TATextfiledPlaceHolderTextColor
        textfiled.font = config.TATextfiledPlaceHolderTextFont
        textfiled.layer.borderColor = config.TATextfiledPlaceHolderBorderColor.cgColor
        textfiled.layer.borderWidth = CGFloat(config.TATextfiledPlaceHolderBorderWidth)
        textfiled.layer.cornerRadius = CGFloat(config.TATextfiledPlaceHolderCornerRadius)
    }
    
    
    //MARK: Valide Button
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
    
    //MARK: HeaderLogo
    public func setThemsForHeaderViewImageORLogo(img: UIImageView, config: TAImage){
        img.image = config.TAImageLogo
    }
    
    //MARK: SetDefaultThems
    public func setMobileDefaultThemes(){
        let mobileConfig = themsConfiguration()
        self.setThemeWithMobileConfiguration(config: mobileConfig)
    }
    
    //MARK: Configure DefaultThems
    func themsConfiguration() -> AuthenticationConfiguration{
        let config = AuthenticationConfiguration()
        let containerView = TAUIView()
        let imgLogo = TAImage()
        let lblLogin = TALable()
        let lblMobile = TALable()
        let lblCountryCode = TALable()
        let lblCountryCodeIcon = TALable()
        let tfView = TAUIView()
        let viewCountryCode = TAUIView()
        let btnCuntryCode = TAButton()
        let textField = TATextFiled()
        let lblEnterValidMobile = TALable()
        let btnValide = TAButton()
        
        
        //MARK: ContainerView
        containerView.TAViewCornerRadius = 10
        containerView.TAviewShadowColor = .gray
        containerView.TAviewShadowOpacity = 0.4
        containerView.TAviewShadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.TAviewShadowRadius = 6
        containerView.TAviewHeight = 350
        
        
        //MARK: Header Img Logo
        imgLogo.TAImageLogo = UIImage(named: "\("logo2")") ?? UIImage()
        
        
        //MARK: HeaderView Txt
        lblLogin.TAText = "Login"
        lblLogin.TATextColor = #colorLiteral(red: 0.07677120715, green: 0.07693774253, blue: 0.0824514851, alpha: 1)
        lblLogin.TATextAlignment = .left
        lblLogin.TATextFont = .boldSystemFont(ofSize: 28)
        
        //MARK: Mobile Txt
        lblMobile.TAText = "Mobile"
        lblMobile.TATextColor = #colorLiteral(red: 0.07677120715, green: 0.07693774253, blue: 0.0824514851, alpha: 1)
        lblMobile.TATextAlignment = .left
        lblMobile.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        
        
        //MARK: Mobile TextFiled View
        tfView.TAViewCornerRadius = 5
        tfView.TAviewborderWidth = 1
        tfView.TAviewTfBorderColor = #colorLiteral(red: 0.6399982572, green: 0.6399982572, blue: 0.6399982572, alpha: 1)
        
        
        //MARK: Country Code Label
        lblCountryCode.TAText = "+91"
        lblCountryCode.TATextColor = .black
        lblCountryCode.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        lblCountryCode.TATextAlignment = .left
        lblCountryCode.TATextNumberOfLines = 0
        
        //MARK: Country Code Icon Label
        lblCountryCodeIcon.TAText = "V"
        lblCountryCodeIcon.TATextColor = .black
        lblCountryCodeIcon.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        lblCountryCodeIcon.TATextAlignment = .right
        lblCountryCodeIcon.TATextNumberOfLines = 0
        
        
        //MARK: Email Textfiled
        textField.TATextfiledPlaceHolderText = "abc@yourdomain.com"
        textField.TATextfiledPlaceHolderTextColor = #colorLiteral(red: 0.7176470588, green: 0.7333333333, blue: 0.7490196078, alpha: 1)
        textField.TATextfiledPlaceHolderTextFont = .systemFont(ofSize: 14, weight: .medium)
        
        
        //MARK: CountryCode View
        viewCountryCode.TAviewTfBorderColor = #colorLiteral(red: 0.7176470588, green: 0.7333333333, blue: 0.7490196078, alpha: 1)
        viewCountryCode.TAviewborderWidth = 1
        viewCountryCode.TAViewCornerRadius = 5
        
        
        //MARK: Enter Valid Mobile
        lblEnterValidMobile.TAText = "Please enter valid Mobile Number"
        lblEnterValidMobile.TATextFont = .systemFont(ofSize: 14, weight: .regular)
        lblEnterValidMobile.TATextColor = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2666666667, alpha: 1)
        
        //MARK: valide Btn
        btnValide.TABtnTitleText = "Validate"
        btnValide.TABtnTitleTextColor = .white
        btnValide.TABtnBackgrounColor = #colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.3019607843, alpha: 1)
        btnValide.TABtnTitleTextFont = .systemFont(ofSize: 14, weight: .medium)
        btnValide.TABtnCornerRadius = 5
        btnValide.TABtnMasksToBounds = true
        
       
        //MARK: Assign
        config.containerViewShow = containerView
        config.logoImage = imgLogo
        config.loginLbl = lblLogin
        config.mobileLbl = lblMobile
        config.countryCountryLbl = lblCountryCode
        config.countryCodeIcon = lblCountryCodeIcon
        config.countryCodeView = viewCountryCode
        config.tfView = tfView
        config.countryCodeBtn = btnCuntryCode
        config.firstTextfiled = textField
        config.enterValidMobileNumber = lblEnterValidMobile
        config.validBtn = btnValide
        
     
        return config
    }
    
    //MARK: Set Configurations
    public func setThemeWithMobileConfiguration(config:AuthenticationConfiguration){
        
    //    self.setThemsContainerView(view: viewContainerMobile, config: config.containerViewShow)
        
        self.setThemsForHeaderViewImageORLogo(img: imgLogo, config: config.logoImage)

        self.setThemsForLable(lbl: lblLogin, config: config.loginLbl)
        
        self.setThemsForLable(lbl: lblMobile, config: config.mobileLbl)
        
        self.setThemsForView(view: viewTfMobileNumber, config: config.tfView)
        
        self.setThemsForView(view: viewCountryCode, config: config.countryCodeView)
        
        self.setThemsForLable(lbl: lblCountryCode, config: config.countryCountryLbl)
        
        self.setThemsForLable(lbl: lblIconCountryCode, config: config.countryCodeIcon)
        
        self.setThemsForTextField(textfiled: tfMobileNumber, config: config.firstTextfiled)
        
        self.setThemsForLable(lbl:lblEnterValidMobNum , config: config.enterValidMobileNumber)
        
        self.setThemsForButton(btn: btnValidate, config: config.validBtn)
    }
    
    //MARK: Custom methods
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        tfMobileNumber.delegate = self
        setupToolBar()
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundel = Bundle(for: Mobile_Number.self)
        let nib = bundel.loadNibNamed(nibName, owner: self)?.first as? UIView
        return nib
    }
    
    //MARK: setupToolBar
    func setupToolBar(){
        let barBtn = UIToolbar()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnTapped(_ :)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        barBtn.items = [flexSpace,flexSpace,doneBtn]
        barBtn.sizeToFit()
        tfMobileNumber.inputAccessoryView = barBtn
    }
    
    @objc func doneBtnTapped(_ tap:UITapGestureRecognizer){
        viewContainerMobile.endEditing(true)
    }
    
    //MARK: IBAction
    @IBAction func validBtnAction(_ sender:UIButton) {
        let phoneNumber = self.tfMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let validatePhone = ValidationClass.shared.isPhoneValid(phone: phoneNumber)
        
        if validatePhone.1 == true {
            delegate?.sendPINAction(mobileNumber: tfMobileNumber.text ?? "")
        } else {
            if let topController = TopControllerManager.getTopViewController() {
                AlertManager.shared.showAlert(title: App_Alert_Title, msg: validatePhone.0, action: ok, viewController: topController)
            }
        }
    }
    
    @IBAction func pickerViewBtn(_ sender: UIButton){
       
        let picker = DataPickerClass()
        picker.title = "Country Code"
        picker.value = ""
        picker.dataArr = countryArray
        
        let data = DataPickerController()
        data.dataObj = picker
        data.delegate = self
    
        data.present(data, animated: false)
    }
}

//MARK: UITextFieldDelegate Extension
extension Mobile_Number:UITextFieldDelegate{
    
    //MARK: Keyboard Open
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: valid till 10 Digit
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfMobileNumber{
            
            if range.location < 10{
                print("range",range.location)
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }
}

extension Mobile_Number: PassDataFromPickerProtocol{
    public func PassPickerData(pickerValue: String) {
        
        print("PickerValue",pickerValue)
    }
}
