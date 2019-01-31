//
//  CurrentSemesterViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 08/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit

class CurrentSemesterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return courseSets.filter({$0.lectureType == 0 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).count
        case 1:
            return courseSets.filter({$0.lectureType == 1 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).count
        case 2:
            return courseSets.filter({$0.lectureType == 2 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).count
        default:
            return courseSets.filter({$0.lectureType == 3 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            let sumOf0 = courseSets.filter({$0.lectureType == 0 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).reduce(0, +)
            return "전필: \(sumOf0)학점"
        case 1:
            let sumOf1 = courseSets.filter({$0.lectureType == 1 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).reduce(0, +)
            return "전선: \(sumOf1)학점"
        case 2:
            let sumOf2 = courseSets.filter({$0.lectureType == 2 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).reduce(0, +)
            return "교양: \(sumOf2)학점"
        default:
            let sumOf3 = courseSets.filter({$0.lectureType == 3 && $0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).reduce(0, +)
            return "일선: \(sumOf3)학점"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.orange
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(red: 48/255.0, green: 50/255.0, blue: 52/255.0, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseViewCell
        
        switch indexPath.section {
        case 0:
            cell.courseNameLabel.text = courseSets.filter({$0.lectureType == 0 && $0.semester == currentSemester})[indexPath.row].name
            cell.creditLabel.text = "\(courseSets.filter({$0.lectureType == 0 && $0.semester == currentSemester})[indexPath.row].credit)학점"
        case 1:
            cell.courseNameLabel.text = courseSets.filter({$0.lectureType == 1 && $0.semester == currentSemester})[indexPath.row].name
            cell.creditLabel.text = "\(courseSets.filter({$0.lectureType == 1 && $0.semester == currentSemester})[indexPath.row].credit)학점"
        case 2:
            cell.courseNameLabel.text = courseSets.filter({$0.lectureType == 2 && $0.semester == currentSemester})[indexPath.row].name
            cell.creditLabel.text = "\(courseSets.filter({$0.lectureType == 2 && $0.semester == currentSemester})[indexPath.row].credit)학점"
        default:
            cell.courseNameLabel.text = courseSets.filter({$0.lectureType == 3 && $0.semester == currentSemester})[indexPath.row].name
            cell.creditLabel.text = "\(courseSets.filter({$0.lectureType == 3 && $0.semester == currentSemester})[indexPath.row].credit)학점"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let cell = tableView.cellForRow(at: indexPath) as! CourseViewCell
            courseSets.removeAll {$0.name == cell.courseNameLabel.text && $0.semester == currentSemester}
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if let path = indexPath {
            self.tableView.reloadSections([path.section], with: .none)
            self.reloadCredit()
        }
    }
    
    var titleString = String()
    var currentSemester = Int()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        reloadCredit()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadCredit() {
        let totalCredit = courseSets.filter({$0.semester == currentSemester}).map({ (cInfo) -> Int in return cInfo.credit}).reduce(0, +)
        totalLabel.text = "전체: " + String(totalCredit) + "학점"
    }
}
