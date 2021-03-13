//
//  PackageTableViewCell.swift
//  S&FModules
//
//  Created by Appcare on 21/10/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var sqmTF: UITextField!
    @IBOutlet weak var widthTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var sideTF: UITextField!
    @IBOutlet weak var pricePerTF: UITextField!
    @IBOutlet weak var PerTF: UITextField!
    
    
    @IBOutlet weak var addAnotherSideBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addAnotherBtnAction(_ sender: Any) {
    }
}
