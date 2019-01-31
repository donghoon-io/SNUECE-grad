//
//  ViewController.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 05/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var currentLabel: UILabel! {
        didSet {
            currentLabel.text = "전기정보공학부에 \(currentGrade)년에 입학한"
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = myName
        }
    }
    @IBOutlet weak var textView: UIView! {
        didSet {
            textView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var commentView: UIView! {
        didSet {
            commentView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var commentLabel: UILabel! {
        didSet {
            setType()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = myName
        setupPieChart()
        setType()
        barChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuart)
        currentLabel.text = "전기정보공학부에 \(currentGrade)년에 입학한"
    }
    
    func setType() {
        switch currentType {
        case 0: commentLabel.text = "시스템 테크"
        case 1: commentLabel.text = "디바이스 테크"
        default: commentLabel.text = "컴퓨터 테크"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navController = navigationController!
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let image = UIImage(named: "NavLogo")!
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        imageView.frame = CGRect(x: 0, y: 0, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        setupPieChart()
    }

    func setupPieChart() {
        barChart.chartDescription?.enabled = false
        barChart.isUserInteractionEnabled = false
        barChart.drawGridBackgroundEnabled = false
        barChart.drawBordersEnabled = false
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.minimumIntegerDigits = 1
        leftAxisFormatter.negativeSuffix = " %"
        leftAxisFormatter.positiveSuffix = " %"
        
        let leftAxis = barChart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 15, weight: .semibold)
        leftAxis.labelTextColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75)
        leftAxis.labelCount = 5
        leftAxis.labelPosition = .outsideChart
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 100
        leftAxis.gridColor = .clear
        barChart.rightAxis.enabled = false
        
        let xAxis = barChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 15, weight: .semibold)
        xAxis.labelTextColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75)
        xAxis.gridColor = .clear
        xAxis.labelCount = 3
        xAxis.granularityEnabled = true
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["전공필수\n\(currentCredit(type: .MandatoryMajor))학점", "전공선택\n\(currentCredit(type: .NonMandatoryMajor))학점", "교양\n\(currentCredit(type: .LiberalCourse))학점", "일선\n\(currentCredit(type: .NonMandatoryCourse))학점"])
        xAxis.granularity = 1
        
        barChart.legend.enabled = false
        
        let entries: [BarChartDataEntry] = [BarChartDataEntry(x: 0, y: creditPercent(year: currentGrade, type: .MandatoryMajor)), BarChartDataEntry(x: 1, y: creditPercent(year: currentGrade, type: .NonMandatoryMajor)), BarChartDataEntry(x: 2, y: creditPercent(year: currentGrade, type: .LiberalCourse)), BarChartDataEntry(x: 3, y: 0)]
        
        let dataSet = BarChartDataSet(values: entries, label: "")
        
        let valueFormatter = NumberFormatter()
        valueFormatter.positiveSuffix = "%"
        valueFormatter.maximumFractionDigits = 0
        
        dataSet.valueFormatter = DefaultValueFormatter(formatter: valueFormatter)
        dataSet.valueFont = .systemFont(ofSize: 15, weight: .semibold)
        dataSet.valueTextColor = UIColor(red: 31/255.0, green: 33/255.0, blue: 36/255.0, alpha: 0.75)
        
        dataSet.colors = [NSUIColor(red: 255/255.0, green: 144/255.0, blue: 10/255.0, alpha: 1)]
        barChart.data = BarChartData(dataSet: dataSet)
        
        barChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuart)
    }
}

