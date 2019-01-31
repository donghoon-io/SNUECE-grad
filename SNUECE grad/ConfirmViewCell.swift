//
//  ConfirmViewCell.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 19/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit

protocol ConfirmCellDelegate: class {
    func renew(cell: ConfirmViewCell)
}

class ConfirmViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var creditPickerView = UIPickerView()
    var creditData: [Int] = [0, 1, 2, 3, 4, 5, 6]
    var courseTypePickerView = UIPickerView()
    var courseTypeData: [String] = ["전필", "전선", "교양", "일선"]
    var semesterPickerView = UIPickerView()
    var semesterData: [Int] = []
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case creditPickerView:
            creditTextField.text = String(creditData[row])
        case courseTypePickerView:
            courseTypeTextField.text = courseTypeData[row]
        default:
            if semesterData.count != 0 {
                semesterTextField.text = semesterData.map({ (semester) -> String in
                    return "\(semester/10)-\(semester%10)"
                })[row]
            }
        }
    }
    
    var delegate: ConfirmCellDelegate?
    @IBOutlet weak var semesterTextField: UITextField! {
        didSet {
            semesterTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            semesterTextField.delegate = self
            
        }
    }
    @IBOutlet weak var courseNameTextField: UITextField! {
        didSet {
            courseNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            courseNameTextField.delegate = self
            
        }
    }
    @IBOutlet weak var courseTypeTextField: UITextField! {
        didSet {
            courseTypeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            courseTypeTextField.delegate = self
            
        }
    }
    @IBOutlet weak var creditTextField: UITextField! {
        didSet {
            creditTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            creditTextField.delegate = self
            
        }
    }
    
    override func awakeFromNib() {
        
        creditPickerView.delegate = self
        creditPickerView.dataSource = self
        creditPickerView.selectRow(3, inComponent: 0, animated: false)
        courseTypePickerView.delegate = self
        courseTypePickerView.dataSource = self
        creditTextField.inputView = creditPickerView
        courseTypeTextField.inputView = courseTypePickerView
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.renew(cell: self)
    }
}
