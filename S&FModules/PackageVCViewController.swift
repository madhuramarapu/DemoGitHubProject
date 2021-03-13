//
//  PackageVCViewController.swift
//  Adhub
//
//  Created by Appcare on 16/10/20.
//  Copyright © 2020 Sireesha Siddineni. All rights reserved.
//

import UIKit

class PackageVCViewController: UIViewController {
    
    @IBOutlet weak var FiveViewHeight: NSLayoutConstraint!
    @IBOutlet weak var FourViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ThirdViewHeight: NSLayoutConstraint!
    @IBOutlet weak var SecondViewHeight: NSLayoutConstraint!
    @IBOutlet weak var FristViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var FirstAddBtn: UIButton!
    
    @IBOutlet weak var SecondAddBtn: UIButton!
    @IBOutlet weak var ThirdAddBtn: UIButton!
    @IBOutlet weak var FiveAddBtn: UIButton!
    @IBOutlet weak var FourAddBtn: UIButton!
    @IBOutlet weak var FirstCardView: UIView!
    @IBOutlet weak var SecondCardView: UIView!
    @IBOutlet weak var ThirdCardView: UIView!
    @IBOutlet weak var FourCardView: UIView!
    @IBOutlet weak var FiveCardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicUI()
    }
    
    @IBAction func FirstAddBtnAction(_ sender: Any) {
        basicUIfirstCardView()
        
    }
    @IBAction func SecondAddBtnAction(_ sender: Any) {
        basicUIsecondCardView()
        
    }
    @IBAction func ThirdAddBtnAction(_ sender: Any) {
        basicUIthirdCardView()
        
    }
    @IBAction func FourAddBtnAction(_ sender: Any) {
        basicUIfourCardView()
        
        
    }
    @IBAction func FiveAddBtnAction(_ sender: Any) {
        basicUIfiveCardView()
        
    }
    func basicUI(){
        FirstCardView.isHidden = false
        SecondCardView.isHidden = true
        ThirdCardView.isHidden = true
        FourCardView.isHidden = true
        FiveCardView.isHidden = true
        FristViewHeight.constant = 308
        SecondViewHeight.constant = 0
        ThirdViewHeight.constant = 0
        FourViewHeight.constant = 0
        FiveViewHeight.constant = 0
        viewHeight.constant = 580 + FristViewHeight.constant +  SecondViewHeight.constant + ThirdViewHeight.constant + FourViewHeight.constant + FiveViewHeight.constant
        
    }
    func basicUIfirstCardView(){
        FirstAddBtn.isHidden = true
        FirstCardView.isHidden = false
        SecondCardView.isHidden = false
        ThirdCardView.isHidden = true
        FourCardView.isHidden = true
        FiveCardView.isHidden = true
        FristViewHeight.constant = 338
        SecondViewHeight.constant = 338
        ThirdViewHeight.constant = 0
        FourViewHeight.constant = 0
        FiveViewHeight.constant = 0
        viewHeight.constant = 580 + FristViewHeight.constant +  SecondViewHeight.constant + ThirdViewHeight.constant + FourViewHeight.constant + FiveViewHeight.constant
        
        
    }
    func basicUIsecondCardView(){
        FirstAddBtn.isHidden = true
        SecondAddBtn.isHidden = true
        FirstCardView.isHidden = false
        SecondCardView.isHidden = false
        ThirdCardView.isHidden = false
        FourCardView.isHidden = true
        FiveCardView.isHidden = true
        FristViewHeight.constant = 338
        SecondViewHeight.constant = 338
        ThirdViewHeight.constant = 338
        FourViewHeight.constant = 0
        FiveViewHeight.constant = 0
        viewHeight.constant = 580 + FristViewHeight.constant +  SecondViewHeight.constant + ThirdViewHeight.constant + FourViewHeight.constant + FiveViewHeight.constant
        
        
        
    }
    func basicUIthirdCardView(){
        FirstAddBtn.isHidden = true
        SecondAddBtn.isHidden = true
        ThirdAddBtn.isHidden = true
        FirstCardView.isHidden = false
        SecondCardView.isHidden = false
        ThirdCardView.isHidden = false
        FourCardView.isHidden = false
        FiveCardView.isHidden = true
        FristViewHeight.constant = 338
        SecondViewHeight.constant = 338
        ThirdViewHeight.constant = 338
        FourViewHeight.constant = 338
        FiveViewHeight.constant = 0
        viewHeight.constant = 580 + FristViewHeight.constant +  SecondViewHeight.constant + ThirdViewHeight.constant + FourViewHeight.constant + FiveViewHeight.constant
        
        
        
    }
    func basicUIfourCardView(){
        FirstAddBtn.isHidden = true
        SecondAddBtn.isHidden = true
        ThirdAddBtn.isHidden = true
        FourAddBtn.isHidden = true
        FirstCardView.isHidden = false
        SecondCardView.isHidden = false
        ThirdCardView.isHidden = false
        FourCardView.isHidden = false
        FiveCardView.isHidden = false
        FristViewHeight.constant = 338
        SecondViewHeight.constant = 338
        ThirdViewHeight.constant = 338
        FourViewHeight.constant = 338
        FiveViewHeight.constant = 0
        viewHeight.constant = 580 + FristViewHeight.constant +  SecondViewHeight.constant + ThirdViewHeight.constant + FourViewHeight.constant + FiveViewHeight.constant
        
        
    }
    func basicUIfiveCardView(){
        FirstAddBtn.isHidden = true
        SecondAddBtn.isHidden = true
        ThirdAddBtn.isHidden = true
        FourAddBtn.isHidden = true
        FiveAddBtn.isHidden = true
        FirstCardView.isHidden = false
        SecondCardView.isHidden = false
        ThirdCardView.isHidden = false
        FourCardView.isHidden = false
        FiveCardView.isHidden = false
        FristViewHeight.constant = 338
        SecondViewHeight.constant = 338
        ThirdViewHeight.constant = 338
        FourViewHeight.constant = 338
        FiveViewHeight.constant = 338
        viewHeight.constant = 580 + FristViewHeight.constant +  SecondViewHeight.constant + ThirdViewHeight.constant + FourViewHeight.constant + FiveViewHeight.constant
        
    }
}
