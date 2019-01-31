//
//  SemesterViewCell.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 05/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit

class SemesterViewCell: UICollectionViewCell {
    @IBOutlet weak var currentSemesterLabel: UILabel!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var majorCreditLabel: UILabel!
    @IBOutlet weak var liberalCreditLabel: UILabel!
    @IBOutlet weak var nonCreditLabel: UILabel!
    
    var currentSemesterNumber = Int()
}
