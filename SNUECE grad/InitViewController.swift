//
//  InitViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 12/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class InitViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var profileImage1: UIImageView! {
        didSet {
            profileImage1.clipsToBounds = true
            profileImage1.layer.cornerRadius = profileImage1.bounds.width/2
            profileImage1.alpha = 0
        }
    }
    @IBOutlet weak var profileLabel1: UILabel! {
        didSet {
            profileLabel1.alpha = 0
        }
    }
    @IBOutlet weak var talkLabel1: UILabel! {
        didSet {
            talkLabel1.layer.masksToBounds = true
            talkLabel1.layer.cornerRadius = 3
            talkLabel1.alpha = 0
        }
    }
    @IBOutlet weak var nowTimeLabel1: UILabel! {
        didSet {
            nowTimeLabel1.alpha = 0
        }
    }
    
    @IBOutlet weak var profileImage2: UIImageView! {
        didSet {
            profileImage2.clipsToBounds = true
            profileImage2.layer.cornerRadius = profileImage1.bounds.width/2
            profileImage2.alpha = 0
        }
    }
    @IBOutlet weak var profileLabel2: UILabel! {
        didSet {
            profileLabel2.alpha = 0
        }
    }
    @IBOutlet weak var talkLabel2: UILabel! {
        didSet {
            talkLabel2.layer.masksToBounds = true
            talkLabel2.layer.cornerRadius = 3
            talkLabel2.alpha = 0
        }
    }
    @IBOutlet weak var nowTimeLabel2: UILabel! {
        didSet {
            nowTimeLabel2.alpha = 0
        }
    }
    
    @IBOutlet weak var talkLabel3: UILabel! {
        didSet {
            talkLabel3.layer.masksToBounds = true
            talkLabel3.layer.cornerRadius = 3
            talkLabel3.alpha = 0
        }
    }
    @IBOutlet weak var nowTimeLabel3: UILabel! {
        didSet {
            nowTimeLabel3.alpha = 0
        }
    }
    @IBOutlet weak var view4: UIView! {
        didSet {
            view4.layer.masksToBounds = true
            view4.layer.cornerRadius = 3
            view4.alpha = 0
        }
    }
    @IBOutlet weak var talkLabel4: UILabel!
    @IBOutlet weak var nowTimeLabel4: UILabel! {
        didSet {
            self.nowTimeLabel4.alpha = 0
        }
    }
    
    @IBOutlet weak var view5: UIView! {
        didSet {
            view5.layer.masksToBounds = true
            view5.layer.cornerRadius = 3
            view5.alpha = 0
        }
    }
    @IBOutlet weak var talkLabel5: UILabel!
    @IBOutlet weak var nowTimeLabel5: UILabel! {
        didSet {
            self.nowTimeLabel5.alpha = 0
        }
    }
    
    @IBOutlet weak var profileImage6: UIImageView! {
        didSet {
            profileImage6.clipsToBounds = true
            profileImage6.layer.cornerRadius = profileImage1.bounds.width/2
            profileImage6.alpha = 0
        }
    }
    @IBOutlet weak var profileLabel6: UILabel! {
        didSet {
            profileLabel6.alpha = 0
        }
    }
    @IBOutlet weak var talkLabel6: UILabel! {
        didSet {
            talkLabel6.layer.masksToBounds = true
            talkLabel6.layer.cornerRadius = 3
            talkLabel6.alpha = 0
        }
    }
    @IBOutlet weak var timeLabel6: UILabel! {
        didSet {
            timeLabel6.alpha = 0
        }
    }
    @IBOutlet weak var talkLabel7: UILabel! {
        didSet {
            talkLabel7.layer.masksToBounds = true
            talkLabel7.layer.cornerRadius = 3
            talkLabel7.alpha = 0
        }
    }
    @IBOutlet weak var timeLabel7: UILabel! {
        didSet {
            timeLabel7.alpha = 0
        }
    }
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.alpha = 0
            startButton.isEnabled = false
            startButton.layer.cornerRadius = 15
        }
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        isNotInitial = !isNotInitial
        self.performSegue(withIdentifier: "moveOn", sender: self)
    }
    
    let nameAlert = UIAlertController(title: "이름을 입력하세요", message: "이름은 수집되지 않습니다", preferredStyle: .alert)
    
    var txtField = UITextField()
    
    var okAction = UIAlertAction()
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseSets = coursePreset
        semesterList = semesterPreset
        
        nameAlert.addTextField { (textField) in
            textField.placeholder = "이름"
            textField.keyboardAppearance = .dark
        }
        txtField = nameAlert.textFields![0] as UITextField
        
        
        var date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 eeee"
        let result = formatter.string(from: date)
        
        todayLabel.text = result
        
        okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            myName = self.txtField.text ?? "이름 없음"
            date = Date()
            self.nowTimeLabel4.text = formatter.string(from: date)
            self.talkLabel4.text = myName + "이고, 저는"
            UIView.animate(withDuration: 0.1, delay: 1.0, animations: {
                self.view4.alpha = 1
                self.nowTimeLabel4.alpha = 1
            }) {(bool) in
                let actionSheet = ActionSheetStringPicker(title: "입학년도를 알려주세요", rows: [2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023], initialSelection: 6, doneBlock: { (picker, index, value) in
                    currentGrade = value as! Int
                    print(currentGrade)
                    
                    date = Date()
                    self.nowTimeLabel5.text = formatter.string(from: date)
                    UIView.animate(withDuration: 0.1, delay: 1.0, animations: {
                        self.nowTimeLabel5.alpha = 1
                        self.view5.alpha = 1
                        self.talkLabel5.alpha = 1
                    }) { (bool) in
                        self.talkLabel5.text = "\(currentGrade)년도에 입학했습니다:)"
                        date = Date()
                        self.timeLabel6.text = formatter.string(from: date)
                        UIView.animate(withDuration: 0.1, delay: 2.0, animations: {
                            self.profileImage6.alpha = 1
                            self.profileLabel6.alpha = 1
                            self.talkLabel6.alpha = 1
                            self.timeLabel6.alpha = 1
                        }) { (bool) in
                            self.timeLabel7.text = formatter.string(from: date)
                            UIView.animate(withDuration: 0.1, delay: 2.0, animations: {
                                self.talkLabel7.alpha = 1
                                self.timeLabel7.alpha = 1
                            }) { (bool) in
                                self.startButton.isEnabled = true
                                UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
                                    self.startButton.alpha = 1
                                }) { (bool) in
                                }
                            }
                        }
                    }
                    
                    return
                }, cancel: {ActionMultipleStringCancelBlock in return }, origin: self.view)
                actionSheet?.hideCancel = true
                UIView.animate(withDuration: 0.1, delay: 2.0, animations: {
                }) { (bool) in
                    actionSheet?.show()
                }
            }
        }
        
        okAction.isEnabled = false
        nameAlert.addAction(okAction)
        txtField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        date = Date()
        formatter.dateFormat = "a h:mm"
        nowTimeLabel1.text = formatter.string(from: date)
        
        UIView.animate(withDuration: 0.1, delay: 2.0, animations: {
            self.profileImage1.alpha = 1
            self.profileLabel1.alpha = 1
            self.talkLabel1.alpha = 1
            self.nowTimeLabel1.alpha = 1
        }) { (bool) in
            date = Date()
            self.nowTimeLabel2.text = formatter.string(from: date)
            UIView.animate(withDuration: 0.1, delay: 2.0, animations: {
                self.profileImage2.alpha = 1
                self.profileLabel2.alpha = 1
                self.talkLabel2.alpha = 1
                self.nowTimeLabel2.alpha = 1
                
            }) { (bool) in
                date = Date()
                self.nowTimeLabel3.text = formatter.string(from: date)
                UIView.animate(withDuration: 0.1, delay: 2.0, animations: {
                    self.talkLabel3.alpha = 1
                    self.nowTimeLabel3.alpha = 1
                    
                }) { (bool) in
                    self.present(self.nameAlert, animated: true, completion: nil)
                }
            }
        }
    }
}
