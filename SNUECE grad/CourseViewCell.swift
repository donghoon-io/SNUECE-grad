//
//  CourseViewCell.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 11/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import UIKit

class CourseViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
