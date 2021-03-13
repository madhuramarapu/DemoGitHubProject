//
//  ProductsDetailsTableViewCell.swift
//  S&FModules
//
//  Created by Appcare on 18/10/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import UIKit

class ProductsDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var CellBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        BgView.layer.borderWidth = 1
        BgView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        CellBgView.layer.borderWidth = 1
        CellBgView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
