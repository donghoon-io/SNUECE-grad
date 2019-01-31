//
//  DeveloperViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 09/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import MessageUI

class DeveloperViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var hoonieView: UIView! {
        didSet {
            hoonieView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var sangwonView: UIView! {
        didSet {
            sangwonView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var hooniePic: UIImageView!
    @IBOutlet weak var webButton: UIButton! {
        didSet {
            webButton.layer.masksToBounds = true
            webButton.layer.cornerRadius = 7
        }
    }
    @IBAction func webButtonClicked(_ sender: UIButton) {
         UIApplication.shared.open(URL(string: "https://hoonie.me/")! as URL, options: [:], completionHandler: nil)
    }
    @IBOutlet weak var emailButton: UIButton! {
        didSet {
            emailButton.layer.masksToBounds = true
            emailButton.layer.cornerRadius = 7
        }
    }
    @IBAction func emailButtonClicked(_ sender: UIButton) {
        sendEmail(address: "ssshyhy@snu.ac.kr")
    }
    @IBOutlet weak var fbButton: UIButton! {
        didSet {
            fbButton.layer.masksToBounds = true
            fbButton.layer.cornerRadius = 7
        }
    }
    @IBAction func fbButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://facebook.com/tswiftlove/")! as URL, options: [:], completionHandler: nil)
    }
    @IBOutlet weak var sangwonEmailButton: UIButton! {
        didSet {
            sangwonEmailButton.layer.masksToBounds = true
            sangwonEmailButton.layer.cornerRadius = 7
        }
    }
    @IBAction func sangwonEmailButtonClicked(_ sender: UIButton) {
        sendEmail(address: "sangwon@snu.ac.kr")
    }
    @IBOutlet weak var sangwonFbButton: UIButton! {
        didSet {
            sangwonFbButton.layer.masksToBounds = true
            sangwonFbButton.layer.cornerRadius = 7
        }
    }
    @IBAction func sangwonFbButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://facebook.com/~~~/")! as URL, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    func sendEmail(address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            mail.setSubject("Question about you!")
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
