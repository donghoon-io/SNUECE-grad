//
//  ProgressViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 05/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import Charts
import ActionSheetPicker_3_0


class ProgressViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return semesterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "semesterCell", for: indexPath) as! SemesterViewCell
        
        cell.layer.cornerRadius = 15
        
        let tempSemesterList = semesterList.sorted()
        
        cell.currentSemesterLabel.text = "\(tempSemesterList[indexPath.item]/10)학년 \(tempSemesterList[indexPath.item]%10)학기"
        
        cell.totalCreditLabel.text = "총이수: \(courseSets.filter({$0.semester == tempSemesterList[indexPath.item]}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +))학점"
        cell.majorCreditLabel.text = "전공: \(courseSets.filter({($0.lectureType == 0 || $0.lectureType == 1) && $0.semester == tempSemesterList[indexPath.item]}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +))학점"
        cell.liberalCreditLabel.text = "교양: \(courseSets.filter({$0.lectureType == 2 && $0.semester == tempSemesterList[indexPath.item]}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +))학점"
        cell.nonCreditLabel.text = "일선: \(courseSets.filter({$0.lectureType == 3 && $0.semester == tempSemesterList[indexPath.item]}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +))학점"
        
        cell.currentSemesterNumber = tempSemesterList[indexPath.item]
        
        return cell
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        ActionSheetMultipleStringPicker.show(withTitle: "어느 학기를 추가할까요?", rows: [
            ["1학년", "2학년", "3학년", "4학년", "5학년", "6학년...?", "이젠 졸업하자..."],
            ["1학기", "2학기"]
            ], initialSelection: [1, 1], doneBlock: {
                picker, indexes, values in
                let currentGrade = indexes![0] as! Int
                let currentSemester = indexes![1] as! Int
                
                let semInt = (currentGrade+1)*10+(currentSemester+1)
                if !semesterList.contains(semInt) {
                    semesterList.append(semInt)
                    
                    self.eachSemesterCollectionView.insertItems(at: [IndexPath(item: semesterList.firstIndex(of: semInt)!, section: 0)])
                    self.eachSemesterCollectionView.scrollToItem(at: IndexPath(item: semesterList.firstIndex(of: semInt)!, section: 0), at: .centeredHorizontally, animated: true)
                    
                    self.setupLineChart()
                } else {
                    var style = ToastStyle()
                    style.backgroundColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.8)
                    style.messageColor = .white
                    
                    ToastManager.shared.style = style
                    
                    self.view.makeToast("\(semInt/10)학년 \(semInt%10)학기가 이미 존재합니다")
                }
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBOutlet weak var eachSemesterCollectionView: UICollectionView!
    @IBOutlet weak var earnedLabelView: UIView! {
        didSet {
            earnedLabelView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var eachLabelView: UIView! {
        didSet {
            eachLabelView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewWillAppear(_ animated: Bool) {
        lineChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuart)
        setupLineChart()
        self.eachSemesterCollectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLineChart()
        
        eachSemesterCollectionView.delegate = self
        eachSemesterCollectionView.dataSource = self
        
        let layout = self.eachSemesterCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    
        
        let itemHeight = 200
        
        layout.itemSize = CGSize(width: itemHeight, height: itemHeight)
        
    }
    
    func setupLineChart() {
        lineChart.chartDescription?.enabled = false
        lineChart.isUserInteractionEnabled = false
        lineChart.drawGridBackgroundEnabled = false
        lineChart.drawBordersEnabled = false
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 0
        leftAxisFormatter.minimumIntegerDigits = 1
        
        let leftAxis = lineChart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 15, weight: .semibold)
        leftAxis.labelTextColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75)
        leftAxis.labelCount = 5
        leftAxis.labelPosition = .outsideChart
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = Double(semesterList.map({ (semInt) -> Int in
            let tempCourse = courseSets.filter({$0.semester == semInt}).map({ (cInfo) -> Int in
                return cInfo.credit
            }).reduce(0, +)
            return tempCourse
        }).max() ?? 21) + 1
        leftAxis.gridColor = .clear
        lineChart.rightAxis.enabled = false
        
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 13, weight: .semibold)
        xAxis.labelTextColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75)
        xAxis.gridColor = .lightGray
        xAxis.labelCount = semesterList.count
        xAxis.granularityEnabled = true
        xAxis.valueFormatter = IndexAxisValueFormatter(values: semesterList.map({ (semesterInt) -> String in
            return "\(semesterInt/10)학년\n\(semesterInt%10)학기"
        }))
        xAxis.granularity = 1
        
        lineChart.legend.enabled = false
        
        let entries: [ChartDataEntry] = semesterList.map { (semesterInt) -> ChartDataEntry in
            let indexForSemInt = Double(2 * (semesterInt/10) + semesterInt%10 - 3)
            return ChartDataEntry(x: indexForSemInt, y: Double(courseSets.filter({$0.semester == semesterInt}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +)))
        }
        
        let dataSet = LineChartDataSet(values: entries, label: "")
        dataSet.lineDashLengths = [5, 2.5]
        dataSet.highlightLineDashLengths = [5, 2.5]
        dataSet.setColor(UIColor(red: 253/255.0, green: 153/255.0, blue: 19/255.0, alpha: 1))
        dataSet.lineWidth = 5
        dataSet.drawCirclesEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 9)
        dataSet.formLineDashLengths = [5, 2.5]
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
        
        let gradientColors = [UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75).cgColor, UIColor.darkGray.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        dataSet.fillAlpha = 1
        dataSet.fill = Fill(linearGradient: gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        
        
        let valueFormatter = NumberFormatter()
        valueFormatter.maximumFractionDigits = 0
        
        dataSet.valueFormatter = DefaultValueFormatter(formatter: valueFormatter)
        dataSet.valueFont = .systemFont(ofSize: 15, weight: .semibold)
        dataSet.valueTextColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75)
        
        lineChart.data = LineChartData(dataSet: dataSet)

        lineChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuart)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CurrentSemesterSegue" {
            let destination = segue.destination as! CurrentSemesterViewController
            let senderCell = sender as! SemesterViewCell
            destination.titleString = senderCell.currentSemesterLabel.text ?? ""
            destination.currentSemester = senderCell.currentSemesterNumber
        }
    }
}
