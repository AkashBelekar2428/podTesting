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
    lazy var alert = AlertManager()
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
        containerView.TAViewShadowColor = TAColor.shadowColor
        containerView.TAViewShadowOpacity = 0.4
        containerView.TAViewShadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.TAViewShadowRadius = 6
        containerView.TAViewHeight = 350
        
        
        //MARK: Image Logo
        imgLogo.TAImageLogo = UIImage(named: "\("logo2")") ?? UIImage()
        
        
        //MARK: Login Txt
        lblLogin.TAText = "Login"
        lblLogin.TATextColor = TAColor.textLblColor
        lblLogin.TATextAlignment = .left
        lblLogin.TATextFont = .boldSystemFont(ofSize: 28)
        
        //MARK: Mobile Txt
        lblMobile.TAText = "Mobile"
        lblMobile.TATextColor = TAColor.textLblColor
        lblMobile.TATextAlignment = .left
        lblMobile.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        
        
        //MARK: Mobile TextFiled View
        tfView.TAViewCornerRadius = 5
        tfView.TAViewborderWidth = 1
        tfView.TAViewBorderColor = TAColor.shadowColor
        
        
        //MARK: Country Code Label
        lblCountryCode.TAText = "+91"
        lblCountryCode.TATextColor = TAColor.textLblColor
        lblCountryCode.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        lblCountryCode.TATextAlignment = .left
        lblCountryCode.TATextNumberOfLines = 0
        
        //MARK: Country Code Icon Label
        lblCountryCodeIcon.TAText = "V"
        lblCountryCodeIcon.TATextColor = TAColor.textLblColor
        lblCountryCodeIcon.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        lblCountryCodeIcon.TATextAlignment = .right
        lblCountryCodeIcon.TATextNumberOfLines = 0
        
        
        //MARK: Email Textfiled
        textField.TATextfiledPlaceHolderText = "abc@yourdomain.com"
        textField.TATextfiledPlaceHolderTextColor = TAColor.textLblColor
        textField.TATextfiledPlaceHolderTextFont = .systemFont(ofSize: 14, weight: .medium)
        
        
        //MARK: CountryCode View
        viewCountryCode.TAViewBorderColor = TAColor.placeholderText_borderColor
        viewCountryCode.TAViewborderWidth = 1
        viewCountryCode.TAViewCornerRadius = 5
        
        
        //MARK: Enter Valid Mobile
        lblEnterValidMobile.TAText = "Please enter valid Mobile Number"
        lblEnterValidMobile.TATextFont = .systemFont(ofSize: 14, weight: .regular)
        lblEnterValidMobile.TATextColor = TAColor.validAuthColor
        
        //MARK: valide Btn
        btnValide.TABtnTitleText = "Validate"
        btnValide.TABtnTitleTextColor = TAColor.buttonTextColor
        btnValide.TABtnBackgrounColor = TAColor.buttonBackgroundColor
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
                
        setThemsForHeaderViewImageORLogo(img: imgLogo, config: config.logoImage)

        setThemsForLabel(lbl: lblLogin, config: config.loginLbl)

        setThemsForLabel(lbl: lblMobile, config: config.mobileLbl)

        setThemsForView(view: viewTfMobileNumber, config: config.tfView)

        setThemsForView(view: viewCountryCode, config: config.countryCodeView) //

        setThemsForLabel(lbl: lblCountryCode, config: config.countryCountryLbl)

        setThemsForLabel(lbl: lblIconCountryCode, config: config.countryCodeIcon)

        setThemsForTextField(textfiled: tfMobileNumber, config: config.firstTextfiled)

        setThemsForLabel(lbl:lblEnterValidMobNum , config: config.enterValidMobileNumber)
        
        setThemsForButton(btn: btnValidate, config: config.validBtn)
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
//            if let topController = TopControllerManager.getTopViewController() {
//                AlertManager.shared.showAlert(title: App_Alert_Title, msg: validatePhone.0, action: ok, viewController: topController)
//
//            }
            lblEnterValidMobNum.isHidden = false
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
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lblEnterValidMobNum.isHidden = true
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
