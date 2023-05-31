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
    @IBOutlet weak public var imgHeaderLogo:UIImageView!
    @IBOutlet weak public var lblHeaderLogin:UILabel!
    @IBOutlet weak public var viewHeader:UIView!
    @IBOutlet weak public var btnSendPin:UIButton!
    @IBOutlet weak public var viewContainerMobile:UIView!
    @IBOutlet weak public var viewSpaceHeight:UIView!
    @IBOutlet weak public var tfMobileNum:UITextField!
    @IBOutlet weak public var lblMobile:UILabel!
    @IBOutlet weak public var btnReminder:UIButton!
    @IBOutlet weak public var btnCountrycode:UIButton!
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
    
    //MARK: Valide Button
    public func setThemsForButton(btn:UIButton, config:TAButton){
        btn.setTitle(config.TABtnTitleText, for: .normal)
        btn.setTitleColor(config.TABtnTitleTextColor, for: .normal)
        btn.titleLabel?.font = config.TABtnTitleTextFont
        btn.backgroundColor = config.TABtnBackgrounColor
        btn.layer.cornerRadius = CGFloat(config.TABtnCornerRadius)
        btn.layer.masksToBounds = config.TABtnMasksToBounds
    }
    
    //MARK: Country Button
    public func setThemsForCountryCodeButton(btn:UIButton, config:TAButton){
        btn.setTitle(config.TABtnTitleText, for: .normal)
        btn.setTitleColor(config.TABtnTitleTextColor, for: .normal)
        btn.layer.cornerRadius = CGFloat(config.TABtnCornerRadius)
        btn.layer.borderColor = config.TABtnBoarderColor.cgColor
        btn.layer.borderWidth = CGFloat(config.TABtnBoarderWidth)
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
    
    //MARK: HeaderView
    public func setThemsForHeaderView(view:UIView, config: TAUIView){
        view.backgroundColor = config.TAviewBackgroundColor
    }
    
    //MARK: ContainerView
    public func setThemsContainerView(view:UIView, config: TAUIView){
        view.layer.shadowColor = config.TAviewShadowColor.cgColor
        view.layer.shadowOpacity = Float(config.TAviewShadowOpacity)
        view.layer.shadowOffset = config.TAviewShadowOffset
        view.layer.shadowRadius = CGFloat(config.TAViewCornerRadius)
        view.layer.cornerRadius = CGFloat(config.TAViewCornerRadius)
        self.viewContainerHeight.constant = CGFloat(config.TAViewHeight)
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
        let lblHeader = TALable()
        let lblFirst = TALable()
        let tfFirst = TATextFiled()
        let viewHeader = TAUIView()
        let btnValide = TAButton()
        let imgLogo = TAImage()
        let containerView = TAUIView()
        let btnCountryCode = TAButton()
        
        //MARK: HeaderView Txt
        lblHeader.TAText = "Log in"
        lblHeader.TATextColor = .textLblColor
        lblHeader.TATextAlignment = .left
        lblHeader.TATextFont = .boldSystemFont(ofSize: 20)
        
        //MARK: Mobile Txt
        lblFirst.TAText = "Mobile"
        lblFirst.TATextColor = .textLblColor
        lblFirst.TATextAlignment = .left
        lblFirst.TATextFont = .systemFont(ofSize: 16)
        
        //MARK: Email Textfiled
        tfFirst.TATextfiledPlaceHolderText = "Enter Mobile Number"
        tfFirst.TATextfiledPlaceHolderTextColor = .black
        tfFirst.TATextfiledPlaceHolderBorderColor = .textfiledBoarderColor
        tfFirst.TATextfiledPlaceHolderBorderWidth = 0.5
        tfFirst.TATextfiledPlaceHolderCornerRadius = 5
        tfFirst.TATextfiledPlaceHolderTextFont = .systemFont(ofSize: 14)
        
        //MARK: HeaderView
        viewHeader.TAviewBackgroundColor = .headerBackgroundColor
        
        //MARK: ContainerView
        containerView.TAViewCornerRadius = 5
        containerView.TAviewShadowColor = .gray
        containerView.TAviewShadowOpacity = 0.4
        containerView.TAviewShadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.TAviewShadowRadius = 6
        containerView.TAViewHeight = 350
        
        //MARK: valide Btn
        btnValide.TABtnTitleText = "Send PIN"
        btnValide.TABtnTitleTextColor = .btnTitleColor
        btnValide.TABtnBackgrounColor = .btnBackgroundColor
        btnValide.TABtnTitleTextFont = .boldSystemFont(ofSize: 18)
        btnValide.TABtnCornerRadius = 4
        btnValide.TABtnMasksToBounds = true
        
        //MARK: Header Img Logo
        imgLogo.TAImageLogo = UIImage(named: "\("logo2")") ?? UIImage()
        
        //MARK: Country Code Btn
        btnCountryCode.TABtnTitleText = "+91"
        btnCountryCode.TABtnBoarderColor = .textfiledBoarderColor
        btnCountryCode.TABtnCornerRadius = 4
        btnCountryCode.TABtnTitleTextColor = .black
        btnCountryCode.TABtnBoarderWidth = 1
        
        config.headerLbl = lblHeader
        config.firstLbl = lblFirst
        config.headerView = viewHeader
        config.logoImage = imgLogo
        config.firstTextfiled = tfFirst
        config.valideBtn = btnValide
        config.containerViewShow = containerView
        config.countryCodeBtn = btnCountryCode
        
        return config
    }
    
    //MARK: Set Configurations
    public func setThemeWithMobileConfiguration(config:AuthenticationConfiguration){
        self.setThemsForHeaderView(view: viewHeader, config: config.headerView)
        
        self.setThemsForLable(lbl: lblHeaderLogin, config: config.headerLbl)
        
        self.setThemsForLable(lbl: lblMobile, config: config.firstLbl)
        
        self.setThemsForCountryCodeButton(btn: btnCountrycode, config: config.countryCodeBtn)
        
        self.setThemsForTextField(textfiled: tfMobileNum, config: config.firstTextfiled)
        
        self.setThemsForHeaderViewImageORLogo(img: imgHeaderLogo, config: config.logoImage)
        
        self.setThemsForHeaderView(view: viewSpaceHeight, config: config.headerView)
        
        self.setThemsForButton(btn: btnSendPin, config: config.valideBtn)
        
        self.setThemsContainerView(view: viewContainerMobile, config: config.containerViewShow)
    }
    
    //MARK: Custom methods
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        tfMobileNum.delegate = self
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
        tfMobileNum.inputAccessoryView = barBtn
    }
    
    @objc func doneBtnTapped(_ tap:UITapGestureRecognizer){
        viewContainerMobile.endEditing(true)
    }
    
    //MARK: IBAction
    @IBAction func mobileValidations(_ sender:UIButton) {
        let phoneNumber = self.tfMobileNum.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let validatePhone = ValidationClass.shared.isPhoneValid(phone: phoneNumber)
        
        if validatePhone.1 == true {
            delegate?.sendPINAction(mobileNumber: tfMobileNum.text ?? "")
        } else {
            if let topController = TopControllerManager.getTopViewController() {
                AlertManager.shared.showAlert(title: App_Alert_Title, msg: validatePhone.0, action: ok, viewController: topController)
            }
        }
    }
    
    @IBAction func pickerViewBtn(_ sender: UIButton){
        
    }
}

//MARK: UITextFieldDelegate Extension
extension Mobile_Number:UITextFieldDelegate{
    func PassPickerData(pickerValue: String) {
        print("PickerValue",pickerValue)
    }
    
    //MARK: Keyboard Open
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: valid till 10 Digit
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfMobileNum{
            
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


