//
//  Mobile_PIN.swift
//  Reusable
//
//  Created by Akash Belekar on 28/04/23.
//

import UIKit

// MARK: Protocol PINViewDelegate
public protocol PINViewDelegate{
    func validateBtnAction(pinNumber: String)
}
protocol GenericPINViewDelegate : AnyObject {
    func pinViewDelegate(pinValue: String)
}

public class PINView: UIView {
    
    //MARK: IBOutlets
    @IBOutlet weak public var viewContainerPIN:UIView!
    @IBOutlet weak public var imgLogo:UIImageView!
    @IBOutlet weak public var lblLogin:UILabel!
    @IBOutlet weak public var lblPinDescription:UILabel!
    @IBOutlet weak public var lblPin:UILabel!
    @IBOutlet weak public var lblEnterValidPIN:UILabel!
    @IBOutlet weak public var btnValidate:UIButton!
    @IBOutlet weak public var btnResendPin:UIButton!
    @IBOutlet weak public var viewContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak public var bgViewVerifyPin: UIView!
    @IBOutlet weak public var pinVarTf: UITextField!
    @IBOutlet weak public var txtSixth: UILabel!
    @IBOutlet weak public var txtFifth: UILabel!
    @IBOutlet weak public var txtFourth: UILabel!
    @IBOutlet weak public var txtthird: UILabel!
    @IBOutlet weak public var txtSecond: UILabel!
    @IBOutlet weak public var txtFirst: UILabel!
    @IBOutlet weak public var btnVerifyTextField: UIButton!
    
    //MARK: Variables
    let nibName = "PINView"
    var timer = Timer()
    public var delegate:PINViewDelegate?
    weak var delegatePinView: GenericPINViewDelegate?
    public var pinViewConfig = AuthenticationConfiguration()
    lazy var alert = AlertManager()
    public weak var controller: UIViewController?
    
    //MARK: System methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //MARK: Custom methods
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        pinVarTf.delegate = self
        self.addSubview(view)
        
        pinVarTf.text = ""
        
        let tolBar = UIToolbar()
        tolBar.sizeToFit()
        tolBar.accessibilityIdentifier = "ToolBar"
        let flexSpac = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.endEditing))
        doneBtn.tintColor = .black
        tolBar.setItems([flexSpac,doneBtn], animated: false)
        pinVarTf.inputAccessoryView = tolBar
        
        txtFirst.textColor = .black
        txtSecond.textColor = .black
        txtthird.textColor = .black
        txtFourth.textColor = .black
        txtFifth.textColor = .black
        txtSixth.textColor = .black
        
        let lblArr = [txtFirst,txtSecond,txtthird,txtFourth,txtFifth,txtSixth]
        for lbl in lblArr {
            lbl!.layer.borderColor = UIColor.black.withAlphaComponent(0.30).cgColor
            lbl!.clipsToBounds = true
            lbl!.layer.cornerRadius = 6
            lbl!.layer.borderWidth = 1.0
        }
        
        btnVerifyTextField.isUserInteractionEnabled = true
        let longPressGest = UILongPressGestureRecognizer.init(target: self, action: #selector(self.LongPressRecogniser(_:)))
        btnVerifyTextField.addGestureRecognizer(longPressGest)
    }
    
    @objc func LongPressRecogniser(_ gesture : UILongPressGestureRecognizer){
        if gesture.state == .began{
            if let tagView = self.bgViewVerifyPin.viewWithTag(3211){
                tagView.removeFromSuperview()
            }
            timer.invalidate()
            let location = gesture.location(in: self.bgViewVerifyPin)
            
            var yOrigin : CGFloat = location.y
            print("Y==> \(yOrigin)")
            
            if location.y > 116{
                yOrigin = 71
            } else {
                yOrigin = yOrigin - 45
            }
            
            let btn = UIButton()
            btn.titleLabel?.font = .systemFont(ofSize: 14)
            btn.setTitle("Paste", for: .normal)
            btn.backgroundColor = .white
            btn.setTitleColor(.blue, for: .normal)
            btn.tag = 3211
            btn.frame.size = CGSize(width: 68, height: 32)
            btn.frame.origin = CGPoint(x: location.x - 2, y: 0)
            btn.layer.cornerRadius = 8.0
            btn.clipsToBounds = true
            btn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            btn.isUserInteractionEnabled = true
            bgViewVerifyPin.addSubview(btn)
            btn.addTarget(self, action: #selector(self.pasteBtnRecogniser(_:)), for: .touchUpInside)
            self.bgViewVerifyPin.endEditing(true)
            //bgViewVerifyPin.bringSubviewToFront(btn)
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut){
                btn.transform = .identity
            } completion: { check in
                self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
            }
        }
    }
    // called every time interval from the timer
    @objc func timerAction() {
        if let tagView = self.bgViewVerifyPin.viewWithTag(3211) {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                tagView.removeFromSuperview()
                self.timer.invalidate()
            } completion: { check in
                
            }
        }
    }
    
    @objc func pasteBtnRecogniser(_ sender : UIButton)  {
        print("Paste pin from clipboard")
        self.bgViewVerifyPin.endEditing(true)
        if let tagView = bgViewVerifyPin.viewWithTag(3211) {
            tagView.removeFromSuperview()
            print("View removed")
        }
        
        if let str = UIPasteboard.general.string {
            var tempStr = String()
            if str.count > 0 {
                tempStr = ""
                for (_,value) in str.enumerated() {
                    if let intValue = Int("\(value)") {
                        tempStr += "\(intValue)"
                    }
                }
                if tempStr.count > 6 {
                    var tempPin = String()
                    for (index,value) in tempStr.enumerated() {
                        if index <= 5 {
                            tempPin += "\(value)"
                        }
                    }
                    var tempI = 1
                    txtFirst.text = ""
                    txtSecond.text = ""
                    txtthird.text = ""
                    txtFourth.text = ""
                    txtFifth.text = ""
                    txtSixth.text = ""
                    
                    for char in tempPin  {
                        switch tempI {
                        case 1:
                            txtFirst.text?.append(char)
                            print("Case = \(tempI)")
                        case 2:
                            txtSecond.text?.append(char)
                        case 3:
                            txtthird.text?.append(char)
                        case 4:
                            txtFourth.text?.append(char)
                        case 5:
                            txtFifth.text?.append(char)
                        case 6:
                            txtSixth.text?.append(char)
                        default:
                            print("Error")
                        }
                        print("Case = \(tempI)")
                        tempI+=1
                    }
                    pinVarTf.text = tempPin
                    self.delegatePinView?.pinViewDelegate(pinValue: tempPin)
                } else {
                    if tempStr.count == 6 {
                        var tempI = 1
                        txtFirst.text = ""
                        txtSecond.text = ""
                        txtthird.text = ""
                        txtFourth.text = ""
                        txtFifth.text = ""
                        txtSixth.text = ""
                        for char in tempStr  {
                            switch tempI {
                            case 1:
                                txtFirst.text?.append(char)
                            case 2:
                                txtSecond.text?.append(char)
                            case 3:
                                txtthird.text?.append(char)
                            case 4:
                                txtFourth.text?.append(char)
                            case 5:
                                txtFifth.text?.append(char)
                            case 6:
                                txtSixth.text?.append(char)
                            default:
                                print("Error")
                            }
                            tempI+=1
                        }
                        pinVarTf.text = tempStr
                        self.delegatePinView?.pinViewDelegate(pinValue: tempStr)
                    } else {
                        // ignore if less than 6 digit pin.
                    }
                }
            }
        }
    }
    
    func loadViewFromNib() -> UIView? {
        let bundel = Bundle(for: PINView.self)
        let nib = bundel.loadNibNamed(nibName, owner: self)?.first as? UIView
        return nib
    }
    
    //MARK: SetDefaultThems
    public func setPINDefaultThemes(){
        let pinViewConfig = themsConfiguration()
        self.setThemeWithPINConfiguration(config: pinViewConfig)
    }
    
    //MARK: Configure DefaultThems
    func themsConfiguration() -> AuthenticationConfiguration {
        let config = AuthenticationConfiguration()
        let imgLogo = TAImage()
        let lblLogin = TALable()
        let lblPinDescription = TALable()
        let lblPIN = TALable()
        let lblEnterValidPIN = TALable()
        let btnValid = TAButton()
        let btnResend = TAButton()
        let containerView = TAUIView()
        
        //MARK: ContainerView
        containerView.TAViewCornerRadius = 10
        containerView.TAViewShadowColor = .gray
        containerView.TAViewShadowOpacity = 0.4
        containerView.TAViewShadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.TAViewShadowRadius = 6
        containerView.TAViewHeight = 350
        
        //MARK: Config Logo
        imgLogo.TAImageLogo = UIImage(named: "") ?? #imageLiteral(resourceName: "logo2")
        
        //MARK: Config Login Label
        lblLogin.TAText = "Login"
        lblLogin.TATextColor = TAColor.textLblColor
        lblLogin.TATextFont = .boldSystemFont(ofSize: 28)
        lblLogin.TATextAlignment = .left
        lblLogin.TATextNumberOfLines = 0
        
        //MARK: Description Txt
        lblPinDescription.TAText = "Please enter your 6 Digit PIN"
        lblPinDescription.TATextColor = TAColor.textLblColor
        lblPinDescription.TATextAlignment = .left
        lblPinDescription.TATextFont = .systemFont(ofSize: 14, weight: .regular)
        
        //MARK: PIN Txt
        lblPIN.TAText = "PIN"
        lblPIN.TATextColor = TAColor.textLblColor
        lblPIN.TATextAlignment = .left
        lblPIN.TATextFont = .systemFont(ofSize: 14, weight: .medium)
        
        //MARK: Configu Enter Valid PIN
        lblEnterValidPIN.TAText = "Please enter valid PIN"
        lblEnterValidPIN.TATextColor = TAColor.validAuthColor
        lblEnterValidPIN.TATextAlignment = .left
        lblEnterValidPIN.TATextFont = .systemFont(ofSize: 13, weight: .regular)
        
        //MARK: Valide Btn
        btnValid.TABtnTitleText = "Validate"
        btnValid.TABtnTitleTextColor = TAColor.buttonTextColor
        btnValid.TABtnBackgrounColor = TAColor.buttonBackgroundColor
        btnValid.TABtnTitleTextFont = .systemFont(ofSize: 14, weight: .medium)
        btnValid.TABtnCornerRadius = 5
        btnValid.TABtnMasksToBounds =  true
        
        //MARK: Resend Btn
        btnResend.TABtnTitleText = "Did not receive PIN? Resend"
        btnResend.TABtnTitleTextColor = TAColor.forgotButtonTitleColor
        btnResend.TABtnBackgrounColor = TAColor.buttonTextColor
        btnResend.TABtnTitleTextFont = .systemFont(ofSize: 14, weight: .medium)
       
        
        
        //MARK: Assign Values
        config.logoImage = imgLogo
        config.loginLbl = lblLogin
        config.pinDescription = lblPinDescription
        config.PinLbl = lblPIN
        config.enterValidPin = lblEnterValidPIN
        config.validBtn = btnValid
        config.resendBtn = btnResend
        config.containerViewShow = containerView
        
        return config
    }
    
    //MARK: Set Configurations
    public func setThemeWithPINConfiguration(config:AuthenticationConfiguration) {
      
        setThemsForLabel(lbl: lblLogin, config: config.loginLbl)
        
        setThemsForHeaderViewImageORLogo(img: imgLogo, config: config.logoImage)
                
        setThemsForLabel(lbl: lblPinDescription, config: config.pinDescription)
        
        setThemsForLabel(lbl: lblPin, config: config.PinLbl)
        
        setThemsForLabel(lbl: lblEnterValidPIN, config: config.enterValidPin)
        
        setThemsForButton(btn: btnValidate, config: config.validBtn)
        
        setThemsForButton(btn: btnResendPin, config: config.resendBtn)
        
       // self.setThemsContainerView(view: viewContainerPIN, config: config.containerViewShow)
        
    }
    
    //MARK: IBAction
    @IBAction func validPINBtnAction(_ sender:UIButton) {
        let pinValide = self.pinVarTf.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let trimPIN = ValidationClass.shared.isPINValid(pin: pinValide!)
        
        if trimPIN.1 == true{
            delegate?.validateBtnAction(pinNumber: pinVarTf.text!)
        }else{
          //  let topController = TopControllerManager.getTopViewController()
          //  AlertManager.shared.showAlert(title: App_Alert_Title, msg: trimPIN.0, action: ok, viewController: topController!)
            lblEnterValidPIN.isHidden = false
        }
    }
    
    @IBAction func actionTapToEnterPin() {
        self.pinVarTf.becomeFirstResponder()
    }
    
    @IBAction func didnotReceivePINAction(_ sender:UIButton){
    }
}

//MARK: UITextFieldDelegate Extension
extension PINView: UITextViewDelegate, UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pinVarTf {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            if string.count > 1 {
                var tempStr = ""
                var tempI = 1
                for char in string {
                    tempStr.append(char)
                    switch tempI {
                    case 1:
                        txtFirst.text?.append(char)
                    case 2:
                        txtSecond.text?.append(char)
                    case 3:
                        txtthird.text?.append(char)
                    case 4:
                        txtFourth.text?.append(char)
                    case 5:
                        txtFifth.text?.append(char)
                    case 6:
                        txtSixth.text?.append(char)
                    default:
                        print("Error")
                    }
                    tempI+=1
                }
                pinVarTf.text = tempStr
                return false
            } else {
                let  char = string.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
                
                let currentString: NSString = textField.text! as NSString
                if (currentString as String).count == 6 && isBackSpace != -92 {
                    return false
                }
                
                if (string == " ") {
                    return false
                }
                
                if (pinVarTf.text?.count == 0) {
                    txtFirst.text = string
                }  else if (pinVarTf.text?.count == 1 && isBackSpace == -92){
                    txtFirst.text = ""
                }
                if (pinVarTf.text?.count == 1 ) {
                    txtSecond.text = string
                }
                else if (pinVarTf.text?.count == 2 && isBackSpace == -92)  {
                    txtSecond.text = ""
                }
                
                if (pinVarTf.text?.count == 2)  {
                    txtthird.text = string
                }
                else if (pinVarTf.text?.count == 3 && isBackSpace == -92) {
                    txtthird.text = ""
                }
                
                if (pinVarTf.text?.count == 3)  {
                    txtFourth.text = string
                }
                else if (pinVarTf.text?.count == 4 && isBackSpace == -92) {
                    txtFourth.text = ""
                }
                
                if (pinVarTf.text?.count == 4)  {
                    txtFifth.text = string
                }
                else if (pinVarTf.text?.count == 5 && isBackSpace == -92) {
                    txtFifth.text = ""
                }
                
                if (pinVarTf.text?.count == 5)  {
                    txtSixth.text = string
                }
                else if (pinVarTf.text?.count == 6 && isBackSpace == -92) {
                    txtSixth.text = ""
                }
                if pinVarTf.text != "" {
                    self.delegatePinView?.pinViewDelegate(pinValue: pinVarTf.fullTextWith(range: range, replacementString: string)!)
                }
                return true
            }
        } else{
            return true
        }
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == pinVarTf{
            txtFirst.text = ""
            txtSecond.text = ""
            txtthird.text = ""
            txtFourth.text = ""
            txtFifth.text = ""
            txtSixth.text = ""
            pinVarTf.text = ""
        }
        lblEnterValidPIN.isHidden = true
        
        return true
    }
}

//MARK: UITextFieldDelegate Extension
extension UITextField {
    
    func fullTextWith(range: NSRange, replacementString: String) -> String? {
        
        if let fullSearchString = self.text, let swtRange = Range(range, in: fullSearchString) {
            
            return fullSearchString.replacingCharacters(in: swtRange, with: replacementString)
        }
        return nil
    }
}

