//
//  DataPickerController.swift
//  ANN
//
//  Created by Nishu Sharma on 24/03/22.
//  Copyright © 2022 Prasad Patil. All rights reserved.
//

import UIKit


//MARK: DataPickerClass
public class DataPickerClass{
    var title : String = ""
    var value : String = ""
    var dataArr : [String] = []
    init() {}
}

//MARK: PassDataFromPickerProtocol
public protocol PassDataFromPickerProtocol : class{
    func PassPickerData(pickerValue : String)
}

public class DataPickerController: UIViewController {
    
    //MARK: IBAction
    @IBAction func actionCancel(_ sender : Any){
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func actionDone(_ sender : Any){
        self.delegate?.PassPickerData(pickerValue: self.pickerValue)
        self.delegate = nil
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: IBOutlet
    @IBOutlet weak public var btnCancel : UIButton!
    @IBOutlet weak public var btnDone : UIButton!
    @IBOutlet weak public var viewCover : UIView!
    @IBOutlet weak public var Pickerview : UIPickerView!
    @IBOutlet weak public var constHeightOfviewCover : NSLayoutConstraint!
    @IBOutlet weak public var lblTitle : UILabel!
    
    //MARK: Variables
    var dataObj = DataPickerClass.init()
    var pickerValue = ""
    weak var delegate : PassDataFromPickerProtocol?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
       // self.setupTheme()
       //  self.setupPickerView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.85, options: .curveEaseOut) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.90, options: .curveEaseOut) {
                    
                    self.constHeightOfviewCover.constant = 260
                    self.view.layoutIfNeeded()
                    
                } completion: { check in
                    
                }
            } completion: { (check) in
               
            }
        }
    }
    
    //MARK: Methods
    private func setupTheme() {
        self.constHeightOfviewCover.constant = 0
        self.view.backgroundColor = .clear
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(.black, for: .normal)
        btnCancel.titleLabel?.font = .systemFont(ofSize: 16)
        btnCancel.backgroundColor = .clear
        btnCancel.layer.cornerRadius = 5
        btnDone.layer.cornerRadius = 5
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(.black, for: .normal)
        btnDone.titleLabel?.font = .systemFont(ofSize: 16)
        btnDone.backgroundColor = .gray
        viewCover.backgroundColor = .gray
        lblTitle.font = .systemFont(ofSize: 20)
        lblTitle.textColor = .black
        lblTitle.numberOfLines = 2
        lblTitle.textAlignment = .center
        lblTitle.text = ""
    }
    
   private func setupPickerView(){
        Pickerview.delegate = self
        Pickerview.dataSource = self
        Pickerview.tintColor = .blue
        lblTitle.text = dataObj.title
        
        if dataObj.dataArr != []  {
            Pickerview.reloadAllComponents()
        }
        
        if dataObj.value != ""{
            if let getVal = dataObj.dataArr.firstIndex(of: dataObj.value)
            {
                Pickerview.selectRow(getVal, inComponent: 0, animated: true)
            }
        }
        
    }
    
}

extension DataPickerController : UIPickerViewDelegate,UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return dataObj.dataArr.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return dataObj.dataArr[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        pickerValue = dataObj.dataArr[row]
    }
}
