//
//  SettingsViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 09/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var top1View: UIView! {
        didSet {
            top1View.layer.cornerRadius = 6
        }
    }
    @IBAction func top1Clicked(_ sender: UIButton) {
        print("top1Clicked")
    }
    @IBOutlet weak var top2View: UIView! {
        didSet {
            top2View.layer.cornerRadius = 6
        }
    }
    @IBAction func top2Clicked(_ sender: UIButton) {
    }
    @IBOutlet weak var top3View: UIView! {
        didSet {
            top3View.layer.cornerRadius = 6
        }
    }
    @IBAction func top3Clicked(_ sender: UIButton) {
        let delete = UIAlertController(title: "정말 모든 데이터를 삭제하시겠습니까?", message: "이 실행은 되돌릴 수 없습니다", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            courseSets = []
            semesterList = []
        }
        delete.addAction(cancelAction)
        delete.addAction(deleteAction)
        self.present(delete, animated: true, completion: nil)
    }
    @IBOutlet weak var top4View: UIView! {
        didSet {
            top4View.layer.cornerRadius = 6
        }
    }
    @IBAction func top4Clicked(_ sender: UIButton) {
        sendEmail(address: "ssshyhy@snu.ac.kr")
    }
    @IBOutlet weak var center1View: UIView! {
        didSet {
            center1View.layer.cornerRadius = 6
        }
    }
    @IBAction func center1Clicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://ee.snu.ac.kr/")! as URL, options: [:], completionHandler: nil)
    }
    @IBOutlet weak var center2View: UIView! {
        didSet {
            center2View.layer.cornerRadius = 6
        }
    }
    @IBAction func center2Clicked(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func sendEmail(address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            mail.setSubject("Question about SNUECE grad application!")
            mail.setMessageBody("<p>I have a question.</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            self.view.makeToast("메일 발송 실패! 메일이 설정되어 있는지 확인하세요")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
