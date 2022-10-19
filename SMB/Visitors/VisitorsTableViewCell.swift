//
//  VisitorsTableViewCell.swift
//  SMB
//
//  Created by Vinoth on 25/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import UIKit

class VisitorsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var iv: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(name:String, _ phone:String) {
        nameLbl.text         = name.count == 0 ? "Unknown" : name
        phoneNumberLbl.text  = phone
    }
}
