//
//  TechTreeViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 06/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import SnapKit
import ActionSheetPicker_3_0

class TechTreeViewController: UIViewController, UIScrollViewDelegate {
    
    let liberalColor = UIColor(red: 243/255.0, green: 213/255.0, blue: 155/255.0, alpha: 1)
    let mandatoryMajorColor = UIColor(red: 229/255.0, green: 170/255.0, blue: 143/255.0, alpha: 1)
    let nonMandatoryMajorColor = UIColor(red: 165/255.0, green: 188/255.0, blue: 219/255.0, alpha: 1)
    let nonMandatorybutMandatoryMajorColor = UIColor(red: 170/255.0, green: 197/255.0, blue: 151/255.0, alpha: 1)
    
    
    @IBOutlet weak var techtreeView: UIView! {
        didSet {
            techtreeView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var techtreeText: UILabel!
    
    @IBAction func techChangeButtonClicked(_ sender: UIBarButtonItem) {
        ActionSheetStringPicker.show(withTitle: "테크를 선택하세요!", rows: ["시스템", "디바이스", "컴퓨터"], initialSelection: 0, doneBlock: { (picker, count, value) in
            self.layoutByType(type: count)
            currentType = count
        }, cancel: { (picker) in
            return
        }, origin: sender)
    }
    
    @IBOutlet var viewCollection: Array<UIView>!
    @IBOutlet var stackViewCollection: Array<UIStackView>!
    @IBOutlet var gradeViewCollection: Array<UILabel>!
    
    @IBOutlet var mandatoryMajor: Array<UILabel>!
    @IBOutlet var nonMandatoryMajor: Array<UILabel>!
    @IBOutlet var liberalCourse: Array<UILabel>!
    @IBOutlet var nonButMandatorymajor: Array<UILabel>!
    
    @IBOutlet var deviceMandatoryMajor: Array<UILabel>!
    @IBOutlet var deviceNonMandatoryMajor: Array<UILabel>!
    @IBOutlet var deviceLiberalCourse: Array<UILabel>!
    @IBOutlet var deviceNonButMandatorymajor: Array<UILabel>!
    
    @IBOutlet var computerMandatoryMajor: Array<UILabel>!
    @IBOutlet var computerNonMandatoryMajor: Array<UILabel>!
    @IBOutlet var computerNonButMandatorymajor: Array<UILabel>!
    
    
    func isInCourseSet(course: String) -> Bool {
        if courseSets.contains(where: {$0.name == course}) {
            return true
        }
        return false
    }
    
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.currentPage = 0
            pageControl.numberOfPages = 4
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0) {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: false)
        } else if (scrollView.contentOffset.y < 0) {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: false)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        systemLayout()
        layoutByType(type: currentType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let elseHeight = 60.5 + 37 + (tabBarController?.tabBar.frame.size.height ?? 0)
        
        let height = view.frame.height - topBarHeight - elseHeight
        
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height: height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        scrollView.delegate = self
        
        defaultLayout(scrollViewWidth: scrollViewWidth, scrollViewHeight: scrollViewHeight)
        
        systemLayout()
        layoutByType(type: currentType)
        
        scrollView.contentSize = CGSize(width: view.bounds.width * 4, height: scrollViewHeight)
        
        for (index, item) in stackViewCollection.enumerated() {
            item.snp.makeConstraints { (make) in
                make.left.equalTo(viewCollection[index].snp.left).offset(10)
                make.right.equalTo(viewCollection[index].snp.right).offset(-10)
                make.top.equalTo(viewCollection[index].snp.top).offset(10)
                make.bottom.equalTo(viewCollection[index].snp.bottom).offset(-10)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let page = Int(round(scrollView.contentOffset.x/width))
        pageControl.currentPage = page
    }
    
    func defaultLayout(scrollViewWidth: CGFloat, scrollViewHeight: CGFloat) {
        for (index, item) in viewCollection.enumerated() {
            if index == 0 {
                item.frame = CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight)
            } else {
                item.frame = CGRect(x: scrollViewWidth*CGFloat((index-1)%3+1), y: 0, width: scrollViewWidth, height: scrollViewHeight)
            }
        }
        
        for item in gradeViewCollection {
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
        }
    }
    func systemLayout() {
        let mandatoryString = ["창의공학설계", "기초회로이론 및 실험", "기초전자회로 및 실험", "신호 및 시스템", "기초전자기학 및 연습", "전기공학설계프로젝트"]
        
        for (index, item) in mandatoryMajor.enumerated() {
            item.backgroundColor = mandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == mandatoryString[index]}) ? 1 : 0.5
        }
        
        let nonMandatoryString = ["전기시스템 선형대수", "데이터통신망의 기초", "전력전자공학", "전력시장이론", "디지털신호 처리의 기초", "네트워크 프로토콜 설계 및 실습", "전파공학", "최신제어기법", "로봇공학개론", "전기기기 및 제어", "일본 신전기전자 산업 기술전망", "지능시스템개론", "통신시스템"]
        
        for (index, item) in nonMandatoryMajor.enumerated() {
            item.backgroundColor = nonMandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == nonMandatoryString[index]}) ? 1 : 0.5
        }
        
        let liberalCourseString = ["수학 및 연습 1", "수학 및 연습 2", "물리학 1", "물리학 2", "물리학실험 1", "물리학실험 2", "화생통+실험2", "공학수학 1", "컴퓨터의 개념 및 실습", "공학수학 2"]
        
        for (index, item) in liberalCourse.enumerated() {
            item.backgroundColor = liberalColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == liberalCourseString[index]}) ? 1 : 0.5
        }
        
        let nonButMajor = ["전력 및 에너지시스템의 기초", "전자기학", "아날로그 전자기학", "전기에너지변환", "제어공학개론", "확률변수 및 확률과정의 기초", "통신의 기초"]
        
        for (index, item) in nonButMandatorymajor.enumerated() {
            item.backgroundColor = nonMandatorybutMandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == nonButMajor[index]}) ? 1 : 0.5
        }
    }
    func deviceLayout() {
        let mandatoryString: [String] = ["기초회로이론 및 실험", "기초전자기학 및 연습", "기초전자회로 및 실험", "전기공학설계프로젝트"]
        
        for (index, item) in deviceMandatoryMajor.enumerated() {
            item.backgroundColor = mandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == mandatoryString[index]}) ? 1 : 0.5
        }
        
        let nonMandatoryString: [String] = ["나노소자의 기초", "전자물리의 기초", "마이크로시스템기술개론", "생체계측", "디지털집적회로", "광전자공학", "유기전자소자"]
        
        for (index, item) in deviceNonMandatoryMajor.enumerated() {
            item.backgroundColor = nonMandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == nonMandatoryString[index]}) ? 1 : 0.5
        }
        
        let liberalCourseString: [String] = ["공학수학 2"]
        
        for (index, item) in deviceLiberalCourse.enumerated() {
            item.backgroundColor = liberalColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == liberalCourseString[index]}) ? 1 : 0.5
        }
        
        let nonButMajor: [String] = ["양자역학의 응용", "전자기학", "아날로그 전자회로", "반도체 소자", "전기에너지변환", "생체전기정보공학"]
        
        for (index, item) in deviceNonButMandatorymajor.enumerated() {
            item.backgroundColor = nonMandatorybutMandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == nonButMajor[index]}) ? 1 : 0.5
        }
    }
    func computerLayout() {
        let mandatoryString: [String] = ["프로그래밍방법론", "논리설계 및 실험", "전기공학설계프로젝트"]
        
        for (index, item) in computerMandatoryMajor.enumerated() {
            item.backgroundColor = mandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == mandatoryString[index]}) ? 1 : 0.5
        }
        
        let nonMandatoryString: [String] = ["전기시스템 선형대수", "디지털시스템 설계 및 실험", "알고리즘의 기초", "임베디드 시스템 설계", "운영체제의 기초", "기계학습기초 및 전기정보응용", "디지털집적회로", "딥러닝의 기초", "컴파일러의 기초"]
        
        for (index, item) in computerNonMandatoryMajor.enumerated() {
            item.backgroundColor = nonMandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == nonMandatoryString[index]}) ? 1 : 0.5
        }
        
        let nonButMajor: [String] = ["자료구조의 기초", "컴퓨터조직론"]
        
        for (index, item) in computerNonButMandatorymajor.enumerated() {
            item.backgroundColor = nonMandatorybutMandatoryMajorColor
            item.layer.masksToBounds = true
            item.layer.cornerRadius = 10
            item.alpha = courseSets.contains(where: {$0.name == nonButMajor[index]}) ? 1 : 0.5
        }
    }
    
    func layoutByType(type: Int) {
        switch type {
        case 0:
            for i in 4...9 {
                viewCollection[i].isHidden = true
            }
            for i in 1...3 {
                viewCollection[i].isHidden = false
            }
            systemLayout()
            techtreeText.text = "당신은 <시스템> 테크입니다"
        case 1:
            for i in 1...3 {
                viewCollection[i].isHidden = true
            }
            for i in 7...9 {
                viewCollection[i].isHidden = true
            }
            for i in 4...6 {
                viewCollection[i].isHidden = false
            }
            deviceLayout()
            techtreeText.text = "당신은 <디바이스> 테크입니다"
        default:
            for i in 1...6 {
                viewCollection[i].isHidden = true
            }
            for i in 7...9 {
                viewCollection[i].isHidden = false
            }
            computerLayout()
            techtreeText.text = "당신은 <컴퓨터> 테크입니다"
        }
    }
}

class LineView: UIView {
    var startPoint = CGPoint(x: 0, y: 0)
    var endPoint = CGPoint(x: 0, y: 0)
    init(frame: CGRect, startPoint: CGPoint, endPoint: CGPoint) {
        super.init(frame: frame)
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.blue.cgColor)
            context.setLineWidth(3)
            context.beginPath()
            context.move(to: startPoint) // This would be oldX, oldY
            context.addLine(to: endPoint) // This would be newX, newY
            context.strokePath()
        }
    }
}
