//
//  ConfirmViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 19/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ConfirmCellDelegate {
    
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        courseSets += tempCourseSet
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
       
    }
    
    func renew(cell: ConfirmViewCell) {
        if let index = self.confirmTableView.indexPath(for: cell)?.item {
            tempCourseSet[index].name = cell.courseNameTextField.text ?? "이름 없음"
            tempCourseSet[index].credit = Int(cell.creditTextField.text ?? "0") ?? 0
            switch cell.creditTextField.text {
                case "전필": tempCourseSet[index].lectureType = 0
                case "전선": tempCourseSet[index].lectureType = 1
                case "교양": tempCourseSet[index].lectureType = 2
                default: tempCourseSet[index].lectureType = 3
            }
            tempCourseSet[index].semester = Int((cell.creditTextField.text ?? "1-1").split(separator: "-")[0])!*10+Int((cell.creditTextField.text ?? "1-1").split(separator: "-")[1])!
        }
    }
    
    var courseName = [String]()
    var courseCredit = [Int]()
    var courseType = [String]()
    var totCourseCredit = [Int]()
    var yearContent = [Int]()
    var semesterContent = [String]()
    
    var tempCourseSet = [CourseInfo]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempCourseSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! ConfirmViewCell
        
        cell.courseNameTextField.text = tempCourseSet[indexPath.item].name
        cell.courseTypeTextField.text = courseType[indexPath.item]
        cell.creditTextField.text = String(courseCredit[indexPath.item])
        cell.semesterTextField.text = "\(tempCourseSet[indexPath.item].semester/10)-\(tempCourseSet[indexPath.item].semester%10)"
        
        
        cell.semesterTextField.inputView = cell.semesterPickerView
        cell.semesterData = semesterList
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tempCourseSet.remove(at: indexPath.row)
            self.confirmTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBOutlet weak var confirmTableView: UITableView!
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.layer.masksToBounds = true
            addButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.courseName)
        print(self.courseCredit)
        print(self.courseType)
        print(self.totCourseCredit)
        print(self.yearContent)
        print(self.semesterContent)
        
        confirmTableView.delegate = self
        confirmTableView.dataSource = self
        
        confirmTableView.setEditing(true, animated: true)
    }
    

}
