//
//  AlertManager.swift
//  MFUIAthentication
//
//  Created by Akash Belekar on 29/05/23.
//

import Foundation

public class AlertManager {
    
    //MARK: Singletone
    static public let shared = AlertManager()
    
    public func showAlter(title:String,msg:String,action:String,viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: action, style: .default,handler:{ _ in
            
        })
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
    
    public func showAltersActions(title:String, msg:String, firstAction:String, secondAction:String, firstComplition:@escaping () -> Void,secondComplition:@escaping () -> Void, viewController: UIViewController){
        
        let alter = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: firstAction, style: .default, handler: { _ in
            print("Ok")
            
            firstComplition()
        })
        
        let cancle = UIAlertAction(title: secondAction, style: .cancel,handler: { _ in
            print("Cancle")
            secondComplition()
        })
        
        alter.addAction(ok)
        alter.addAction(cancle)
        
        DispatchQueue.main.async(execute: {
            viewController.present(alter, animated: true)
        })
    }
}

