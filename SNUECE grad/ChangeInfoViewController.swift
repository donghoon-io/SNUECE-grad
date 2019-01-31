//
//  ChangeInfoViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 10/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class ChangeInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameEditButton: UIButton! {
        didSet {
            nameEditButton.layer.masksToBounds = true
            nameEditButton.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = myName
        }
    }
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            yearLabel.text = "\(currentGrade)년도"
        }
    }
    
    var alert = UIAlertController()
    var okAction = UIAlertAction()
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    @IBAction func nameEditButtonClicked(_ sender: UIButton) {
        alert = UIAlertController(title: "이름 바꾸기", message: "이름을 바꿔주세요", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "이름을 입력해주세요"
            textField.text = "신동훈" // 기존 이름
            textField.keyboardAppearance = .dark
        }
        let firstTextField = alert.textFields![0] as UITextField
        firstTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            myName = firstTextField.text ?? "이름 없음"
            self.nameLabel.text = myName
            
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var yearEditButton: UIButton! {
        didSet {
            yearEditButton.layer.masksToBounds = true
            yearEditButton.layer.cornerRadius = 5
        }
    }
    @IBAction func yearEditButtonClicked(_ sender: UIButton) {
        let actionsheet = ActionSheetStringPicker(title: "입학년도를 알려주세요", rows: [2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023], initialSelection: 6, doneBlock:  { (picker, index, value) in
            currentGrade = value as! Int
            self.yearLabel.text = "\(currentGrade)년도"
        }, cancel: {ActionMultipleStringCancelBlock in return }, origin: sender)
        actionsheet?.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
