//
//  LogoutVC.swift
//  S&FModules
//
//  Created by Appcare on 23/10/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import UIKit

class LogoutVC: UIViewController {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var switchAccountBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBAction func signInBtnAction(_ sender: Any) {
    }
    @IBAction func switchAccountBtnAction(_ sender: Any) {
    }
    @IBAction func registerBtnAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userImgView.layer.borderWidth = 1
        userImgView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        switchAccountBtn.layer.borderWidth = 1
        switchAccountBtn.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        signInBtn.layer.borderWidth = 1
        signInBtn.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    

}
