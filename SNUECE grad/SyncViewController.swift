//
//  SyncViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 17/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class SyncViewController: UIViewController, WKNavigationDelegate, WKUIDelegate,  WKScriptMessageHandler {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView! {
        didSet {
            indicatorView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    @IBOutlet weak var nowView: UIView! {
        didSet {
            nowView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var nowLabel: UILabel! {
        didSet {
            nowLabel.text = "로그인중"
        }
    }
    
    var courseName = [String]()
    var courseCredit = [Int]()
    var courseType = [String]()
    var totCourseCredit = [Int]()
    var yearContent = [Int]()
    var semesterContent = [String]()
    
    var isDone = false
    
    private var estimatedProgressObserver: NSKeyValueObservation?
    
    
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "native_console_log") {
            native_console_log(didReceive: message)
        }
    }
    
    func native_console_log(didReceive message: WKScriptMessage) {
        print((string: "console.log: \(message.body)"))
    }
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.alpha = 0
            progressView.progress = 0
        }
    }
    @IBOutlet weak var webView: WKWebView!
    
    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        let url = URL(string: "https://sso.snu.ac.kr/3rdParty/loginFormPage.jsp?NONCE=VJGsF9IfT1G9eAFD7ZKCcOBfSiVzU3CdXkM2MevUgzZNImMI7%2BtSZGUAiUA05lrjqQup9I6VRnhXueC0aD5Rsg%3D%3D&UURL=https%3A%2F%2Fsso.snu.ac.kr%2Fnls3%2Ffcs")
        let request = URLRequest(url: url!)
        webView?.load(request)
        setupEstimatedProgressObserver()
    }
    func showProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }
    
    func hideProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0
        }, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideProgressView()
        if !isDone {
            isDone = !isDone
        webView.evaluateJavaScript("document.getElementById('si_id').value='\(myId)'; document.getElementById('si_pwd').value='\(myPassword)'; document.getElementById('btn_login').click();") { (html, error) in
            if error != nil {
                print(error)
            } else {
                self.nowLabel.text = "메인으로 이동중"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.webView?.evaluateJavaScript("document.location = \"http://my.snu.ac.kr/mysnu/portal/MS010/MAIN\";", completionHandler: { (html, error) in
                        if error != nil {
                            print(error)
                        } else {
                            self.nowLabel.text = "성적 탭 찾는중"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                                self.webView?.evaluateJavaScript("document.location = \"http://my.snu.ac.kr/mysnu/portal/MS010/ko/TO980/SB020/ME030?lanCd=ko\"", completionHandler: { (html, error) in
                                    if error != nil {
                                        print(error)
                                    } else {
                                        self.nowLabel.text = "성적 요소 찾는중"
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0, execute: {
                                            self.webView?.evaluateJavaScript("document.location = document.querySelector(\"iframe\").src;", completionHandler: { (html, error) in
                                                if error != nil {
                                                    print(error)
                                                } else {
                                                    self.nowLabel.text = "크롤링 하는중"
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 12.0, execute: {
                                                        self.webView?.evaluateJavaScript("var niemi0 = new Array();for (var i = 0; i< haksaContents.sbjtNm.length-1; i++) {niemi0.push(haksaContents.sbjtNm[i].innerText);} var niemi1 = new Array();for (var i = 0; i< haksaContents.acqPnt.length-1; i++) {niemi1.push(parseInt(haksaContents.acqPnt[i].innerText));} var niemi2 = new Array();for (var i = 0; i< haksaContents.cptnSubmattFgCdNm.length-1; i++) {niemi2.push(haksaContents.cptnSubmattFgCdNm[i].innerText);}  var niemi3 = new Array(); for (var i = 0; i< haksaContents.cptnPnt.length; i++) {niemi3.push(parseInt(haksaContents.cptnPnt[i].innerText));} var niemi4 = new Array();for (var i = 0; i< haksaContents.schyy.length; i++) {niemi4.push(parseInt(haksaContents.schyy[i].innerText));} var niemi5 = new Array();for (var i = 0; i< haksaContents.shtmDetaShtm.length; i++) {niemi5.push(haksaContents.shtmDetaShtm[i].innerText);} JSON.stringify([niemi0, niemi1, niemi2, niemi3, niemi4, niemi5]);", completionHandler: { (html, error) in
                                                            
                                                            if let json1 = html as? String {
                                                                let json = JSON(parseJSON: json1)
                                                                self.courseName = json[0].arrayObject as! [String]
                                                                self.courseName.reverse()
                                                                self.courseCredit = json[1].arrayObject as! [Int]
                                                                self.courseCredit.reverse()
                                                                self.courseType = json[2].arrayObject as! [String]
                                                                self.courseType.reverse()
                                                                self.totCourseCredit = json[3].arrayObject as! [Int]
                                                                self.totCourseCredit.reverse()
                                                                self.yearContent = json[4].arrayObject as! [Int]
                                                                self.yearContent.reverse()
                                                                self.semesterContent = json[5].arrayObject as! [String]
                                                                self.semesterContent.reverse()
                                                                
                                                                self.nowLabel.text = "완료"
                                                                
                                                                self.performSegue(withIdentifier: "goToTable", sender: self)
                                                            } else {
                                                                print("error")
                                                            }
                                                        })
                                                    })
                                                }
                                            })
                                        })
                                    }
                                })
                            })
                        }
                    })
                })
            }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgressView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideProgressView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTable" {
            let vc = segue.destination as! ConfirmViewController
            vc.courseName = courseName
            vc.courseCredit = courseCredit
            vc.courseType = courseType
            vc.totCourseCredit = totCourseCredit
            vc.yearContent = yearContent
            vc.semesterContent = semesterContent
            
            var tempCourseArray = [CourseInfo]()
            
            var sum = 0
            var curIdx = 0
            for (index, item) in courseName.enumerated() {
                var tempSem = 0
                
                var tempType = 0
                switch courseType[index] {
                case "전필": tempType = 0
                case "전선": tempType = 1
                case "교양": tempType = 2
                default: tempType = 3
                }
                var tempCourse: CourseInfo?
                
                if sum + courseCredit[index] > totCourseCredit[curIdx] {
                    curIdx += 1
                    sum -= totCourseCredit[curIdx - 1]
                }
                
                if semesterContent[curIdx] == "1학기" || semesterContent[curIdx] == "여름학기" {
                    tempSem = 1
                } else {
                    tempSem = 2
                }
                
                tempCourse = CourseInfo(name: courseName[index], semester: (yearContent[curIdx]-currentGrade+1)*10+tempSem, credit: courseCredit[index], lectureType: tempType)
                
                sum += courseCredit[index]
                tempCourseArray.append(tempCourse ?? CourseInfo(name: "nil", semester: 00, credit: 0, lectureType: 0))
            }
            vc.tempCourseSet = tempCourseArray
        }
    }
}
