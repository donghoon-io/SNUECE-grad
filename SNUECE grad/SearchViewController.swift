//
//  SearchViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 06/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import ModernSearchBar

class SearchViewController: UIViewController, ModernSearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func onClickItemSuggestionsView(item: String) {
        let array = item.components(separatedBy: ", ")
        let name = array[0]
        let tempType = array[1]
        var type = Int()
        switch tempType {
        case "전필": type = 0
        case "전선": type = 1
        case "교양": type = 2
        default: type = 3
        }
        let credit = Int(array[2].components(separatedBy: "학점")[0])
        
        tempName = name
        tempCredit = credit ?? 0
        tempCourseType = type
        
        courseNameTextField.text = name
        creditTextField.text = "\(credit ?? 0)학점"
        courseTypeTextField.text = tempType
        
        searchBar.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case creditPickerView: return creditData.count
        case courseTypePickerView: return courseTypeData.count
        default: return semesterData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case creditPickerView: return "\(creditData[row])학점"
        case courseTypePickerView: return courseTypeData[row]
        default: return semesterData.map({ (semester) -> String in
            return "\(semester/10)학년 \(semester%10)학기"
        })[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case creditPickerView:
            creditTextField.text = "\(creditData[row])학점"
            tempCredit = creditData[row]
        case courseTypePickerView:
            courseTypeTextField.text = courseTypeData[row]
            tempCourseType = row
        default:
            if semesterData.count != 0 {
                semesterTextField.text = semesterData.map({ (semester) -> String in
                    return "\(semester/10)학년 \(semester%10)학기"
                })[row]
                tempSemester = semesterData[row]
            }
        }
    }
    

    @IBOutlet weak var searchBar: ModernSearchBar! {
        didSet {
            searchBar.backgroundImage = UIImage()
            let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1)
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar?.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1)
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1)
        }
    }
    @IBOutlet weak var addView: UIView! {
        didSet {
            addView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.layer.cornerRadius = 10
            addButton.layer.masksToBounds = true
        }
    }
    @IBAction func addButtonClicked(_ sender: UIButton) {
        if semesterTextField.text == "" || courseNameTextField.text == "" || courseTypeTextField.text == "" || creditTextField.text == "" {
            view.makeToast("모든 항목을 입력하세요")
        } else if courseSets.contains(where: {$0.name == tempName && $0.semester == tempSemester}) {
            view.makeToast("강좌가 그 학기에 이미 존재합니다")
        } else {
            courseSets.append(CourseInfo(name: tempName, semester: tempSemester, credit: tempCredit, lectureType: tempCourseType))
            view.makeToast("강좌가 추가되었습니다")
        }
    }
    @IBOutlet weak var courseNameTextField: UITextField! {
        didSet {
            courseNameTextField.attributedPlaceholder = NSAttributedString(string: "강의명을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 246/255.0, green: 245/255.0, blue: 251/255.0, alpha: 0.7)])
        }
    }
    @IBOutlet weak var creditTextField: UITextField! {
        didSet {
            creditTextField.attributedPlaceholder = NSAttributedString(string: "학점을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 246/255.0, green: 245/255.0, blue: 251/255.0, alpha: 0.7)])
        }
    }
    var creditPickerView = UIPickerView()
    var creditData: [Int] = [0, 1, 2, 3, 4, 5, 6]
    @IBOutlet weak var courseTypeTextField: UITextField! {
        didSet {
            courseTypeTextField.attributedPlaceholder = NSAttributedString(string: "강의구분을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 246/255.0, green: 245/255.0, blue: 251/255.0, alpha: 0.7)])
        }
    }
    var courseTypePickerView = UIPickerView()
    var courseTypeData: [String] = ["전필", "전선", "교양", "일선"]
    @IBOutlet weak var semesterTextField: UITextField! {
        didSet {
            semesterTextField.attributedPlaceholder = NSAttributedString(string: "학기를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 246/255.0, green: 245/255.0, blue: 251/255.0, alpha: 0.7)])
        }
    }
    @IBOutlet weak var syncButton: UIButton! {
        didSet {
            syncButton.layer.masksToBounds = true
            syncButton.layer.cornerRadius = 10
        }
    }
    var semesterPickerView = UIPickerView()
    var semesterData: [Int] = []
    
    var tempName = String()
    var tempCredit = Int()
    var tempCourseType = Int()
    var tempSemester = Int()
    
    override func viewWillAppear(_ animated: Bool) {
        semesterData = semesterList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegateModernSearchBar = self
        hideKeyboardWhenTappedAround()
        
        courseNameTextField.delegate = self
        creditPickerView.delegate = self
        creditPickerView.dataSource = self
        creditPickerView.selectRow(3, inComponent: 0, animated: false)
        creditTextField.inputView = creditPickerView
        creditTextField.delegate = self
        courseTypePickerView.delegate = self
        courseTypePickerView.dataSource = self
        courseTypeTextField.inputView = courseTypePickerView
        courseTypeTextField.delegate = self
        semesterPickerView.delegate = self
        semesterPickerView.dataSource = self
        semesterTextField.inputView = semesterPickerView
        semesterTextField.delegate = self
        
        loadSemester()
        
        let strSet = everyList.map { (key, value) -> String in
            key + ", " + returnType(courseId: key) + ", " + String(value) + "학점"
        }
        
        self.searchBar.setDatas(datas: strSet)
        
    }
    
    func loadSemester() {
        semesterData = semesterList
    }
}

extension SearchViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
}
