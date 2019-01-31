//
//  SyncTutorialViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 17/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SyncTutorialViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idInput: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var pwInput: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.alpha = 0.7
            startButton.layer.masksToBounds = true
            startButton.layer.cornerRadius = 15
            startButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idInput.delegate = self
        pwInput.delegate = self
        idInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pwInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idInput.text != "" && pwInput.text != "" {
            startButton.alpha = 1
            startButton.isEnabled = true
        } else {
            startButton.alpha = 0.7
            startButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "realSync" {
            myId = idInput.text!
            myPassword = pwInput.text!
        }
    }
}

extension SyncTutorialViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SyncTutorialViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
