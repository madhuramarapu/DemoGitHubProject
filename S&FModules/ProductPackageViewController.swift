//
//  ProductPackageViewController.swift
//  S&FModules
//
//  Created by Appcare on 21/10/20.
//  Copyright © 2020 Appcare. All rights reserved.
//

import UIKit
class ProductPackageViewController: UIViewController {
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var viewHeigth: NSLayoutConstraint!
    @IBAction func SubmitAction(_ sender: Any) {
        tapsOnNext()
        
    }
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    var nameArray = [String]()
    var TFArray =  [String]()
    var SqmArryTF = [String]()
    var SqmArryTF1 = [String]()
    var dictArray = [Int:Any]()
    var totalproductArray = [["sqmTF":"","widthTF":"","heightTF":"","sideTF":"","pricePerTF":"","PerTF":""]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameArray = [""]
        
        //        dictArray["0"] = ["Name":"vikas"]
        //        dictArray["1"] = ["Age":"25"]
        
        print(dictArray)
    }
}
extension ProductPackageViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == detailsTableView{
            return nameArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "PackageTableViewCell", for: indexPath) as! PackageTableViewCell
        cell.addAnotherSideBtn.tag = indexPath.row
        cell.addAnotherSideBtn.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
        cell.sqmTF.tag = indexPath.row
        cell.selectionStyle = .none
        if nameArray.count == 0{
            print("ji")
        }else {
            
            //  cell.sqmTF.text = TFArray[indexPath.row]
            //cell.sqmTF.tag = indexPath.row + 1
            if nameArray.count == 4 {
                cell.addAnotherSideBtn.isHidden = true
            }
            else {
                if nameArray.count == 1{
                    cell.addAnotherSideBtn.isHidden = false
                }else if  nameArray.count == 2{
                    if indexPath.row == 0 {
                        cell.addAnotherSideBtn.isHidden = true
                    }else{
                        cell.addAnotherSideBtn.isHidden = false
                    }
                }else if  nameArray.count == 3{
                    if indexPath.row == 0 {
                        cell.addAnotherSideBtn.isHidden = true
                    }else if indexPath.row == 1{
                        cell.addAnotherSideBtn.isHidden = true
                    }else if indexPath.row == 2{
                        cell.addAnotherSideBtn.isHidden = false
                    }
                }else if  nameArray.count == 4{
                    if indexPath.row == 0 {
                        cell.addAnotherSideBtn.isHidden = true
                    }else if indexPath.row == 1{
                        cell.addAnotherSideBtn.isHidden = true
                    }else if indexPath.row == 2{
                        cell.addAnotherSideBtn.isHidden = true
                    }else if indexPath.row == 3{
                        cell.addAnotherSideBtn.isHidden = false
                    }
                }
                else if  nameArray.count == 5{
                    if indexPath.row == 4{
                        cell.addAnotherSideBtn.isHidden = false
                    }else{
                        cell.addAnotherSideBtn.isHidden = true
                    }
                }
            }
        }
        
        return cell
    }
    @objc func deleteAction(sender: UIButton)
    {
        if nameArray.count > 4 {
            print("no sides added")
        }else {
            self.nameArray.append("")
            self.TFArray.append("")
            if nameArray.count == 1 {
                tableViewheight.constant = CGFloat(nameArray.count * 450 )
                print("ok",tableViewheight.constant)
                print("okk",nameArray.count)
                viewHeigth.constant = 500 + tableViewheight.constant
                print("okk", viewHeigth.constant)
                detailsTableView.reloadData()
            }else if nameArray.count == 2 {
                let count = nameArray.count - 1
                tableViewheight.constant = CGFloat(count * 450 )
                print("ok",tableViewheight.constant)
                print("okk",nameArray.count)
                viewHeigth.constant = 500 + tableViewheight.constant
                print("okk", viewHeigth.constant)
                detailsTableView.reloadData()
            }else{
                let count = nameArray.count - 1
                tableViewheight.constant = CGFloat(count * 450 )
                print("ok",tableViewheight.constant)
                print("okk",nameArray.count)
                viewHeigth.constant = 500 + tableViewheight.constant
                print("okk", viewHeigth.constant)
                detailsTableView.reloadData()
            }
        }
        
        
    }
    func tapsOnNext(){
        SqmArryTF.removeAll()
        for i in 0..<nameArray.count {
            let indexpath = IndexPath(row:i, section: 0)
            let cell = detailsTableView.cellForRow(at: indexpath) as! PackageTableViewCell
            print(cell.sqmTF.text ?? "")
            dictArray[indexpath.row] = ["name": cell.sqmTF.text!]
            self.totalproductArray.append(["sqmTF":cell.sqmTF.text!,"widthTF":cell.widthTF.text!,"heightTF":cell.heightTF.text!,"sideTF":cell.sideTF.text!,"pricePerTF":cell.pricePerTF.text!,"PerTF":cell.PerTF.text!])
            SqmArryTF.append(cell.sqmTF.text ?? "")
            print("o",SqmArryTF)
           print("totalproductArray",totalproductArray)
        }
        print("sqm",dictArray)
        
    }
}
