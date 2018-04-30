//
//  TableViewController.swift
//  Latipay_Demo
//
//  Created by Tonny on 14/11/17.
//  Copyright © 2017 Latipay. All rights reserved.
//

import UIKit
import LatipaySDK

class TableViewController: UITableViewController {
    
    var dataSource: Array<Dictionary<String, String>>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: "list", withExtension: "plist")!
        dataSource = NSArray(contentsOf: url)! as! Array<Dictionary<String, String>>
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let obj = dataSource[indexPath.row]
        
        let imgView = cell.viewWithTag(1) as! UIImageView
        imgView.image = UIImage(named: "\(obj["id"]!).jpg")
        
        let titleLbl = cell.viewWithTag(2) as! UILabel
        titleLbl.text = obj["product_name"]
        
        let priceLbl = cell.viewWithTag(3) as! UILabel
        priceLbl.text = "$\(obj["amount"]!)"
        
        let alipayBtn = cell.viewWithTag(4) as! UIButton
        alipayBtn.addTarget(self, action:#selector(TableViewController.alipay), for: UIControlEvents.touchUpInside)
        
        let wechatBtn = cell.viewWithTag(5) as! UIButton
        wechatBtn.addTarget(self, action:#selector(TableViewController.wechat), for: UIControlEvents.touchUpInside)

        return cell
    }
    
    @objc func alipay(_ btn: UIButton?) {
        guard let cell = btn?.superview?.superview as? UITableViewCell,
            let row = tableView.indexPath(for: cell)?.row else {
            return
        }
        let data = dataSource[row]
        let para = ["payment_method": "alipay",
                    "amount": data["amount"]!,
                    "merchant_reference":"12312-12312312-12312-213123",
                    "product_name": data["product_name"]!, //optional
                    "callback_url":"https://yourwebsite.com/latipay/callback"]
        
        LatipaySDK.payOrder(para, completion: self.dealwithLatipayResult)
    }
    
    @objc func wechat(_ btn: UIButton?) {
        guard let cell = btn?.superview?.superview as? UITableViewCell,
            let row = tableView.indexPath(for: cell)?.row else {
                return
        }
        let data = dataSource[row]
        let para = ["payment_method": "wechat",
                    "amount": data["amount"]!,
                    "merchant_reference":"12312-12312312-12312-213123",
                    "product_name": data["product_name"]!, //optional
                    "callback_url":"https://yourwebsite.com/latipay/callback"]
        
        LatipaySDK.payOrder(para, completion: self.dealwithLatipayResult)
    }
    
    func dealwithLatipayResult(latipayOrder: Dictionary<String, String>?, error: Error?)  {
        if let e = error {
            UIAlertView(title: "", message: e.localizedDescription, delegate: nil, cancelButtonTitle: "Cancel").show()
            return
        }
        
        if let order = latipayOrder {
            let paymentId = order["payment_id"]!
            let status = order["status"]!           //"pending", here always pending
            let method = order["payment_method"]!
            
            print("method: \(method) paymentId: \(paymentId) status: \(status)")
            
            //recommend to save paymentId in server for checking payment status later.
        }
    }
}
