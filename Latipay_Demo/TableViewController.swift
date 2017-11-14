//
//  TableViewController.swift
//  Latipay_Demo
//
//  Created by Tonny on 14/11/17.
//  Copyright © 2017 Latipay. All rights reserved.
//

import UIKit
import LatipaySDK_Swift

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
        priceLbl.text = "$\(obj["price"]!)"
        
        let alipayBtn = cell.viewWithTag(4) as! UIButton
        alipayBtn.addTarget(self, action:#selector(TableViewController.alipay), for: UIControlEvents.touchUpInside)
        
        let wechatPayBtn = cell.viewWithTag(5) as! UIButton
        wechatPayBtn.addTarget(self, action:#selector(TableViewController.wechatPay), for: UIControlEvents.touchUpInside)

        return cell
    }
    
    @objc func alipay(_ btn: UIButton?) {
        guard let cell = btn?.superview?.superview as? UITableViewCell,
            let row = tableView.indexPath(for: cell)?.row else {
            return
        }
        let data = dataSource[row]
        let para = ["payment_method": LatipayMethod.alipay.rawValue,
                    "amount": "1",
                    "merchant_reference":"reference",
                    "product_name": data["product_name"]!,
                    "price": data["price"]!]
        
        LatipaySDK.pay(order: para) {[weak self] (result, error) in
            self?.dealwithLatipayResult(result: result, error: error)
        }
    }
    
    @objc func wechatPay(_ btn: UIButton?) {
        guard let cell = btn?.superview?.superview as? UITableViewCell,
            let row = tableView.indexPath(for: cell)?.row else {
                return
        }
        let data = dataSource[row]
        let para = ["payment_method": LatipayMethod.wechatpay.rawValue,
                    "amount": "1",
                    "merchant_reference":"reference",
                    "product_name": data["product_name"]!,
                    "price": data["price"]!]
        
        LatipaySDK.pay(order: para) {[weak self] (result, error) in
            self?.dealwithLatipayResult(result: result, error: error)
        }
    }
    
    func dealwithLatipayResult(result: Dictionary<String, String>?, error: LatipayError?)  {
        if let e = error {
            UIAlertView(title: "", message: e.localizedDescription, delegate: nil, cancelButtonTitle: "Cancel").show()
            return
        }
        
        if let result = result {
            let orderId = result["order_id"]!
            let status = result["status"]!           //"unpaid", here always unpaid
            let method = result["payment_method"]!   //"alipay"
            
            print("method: \(method) orderId: \(orderId) status: \(status)")
            
            //recommend to save orderId in server for checking payment status later.
        }
    }
}
