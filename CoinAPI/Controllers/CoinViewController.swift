//
//  CoinViewController.swift
//  CoinAPI
//
//  Created by 王佩豪 on 2023/12/29.
//

import UIKit

class CoinViewController:UIViewController{
    
    
    var rate:String = ""
    var target:String = ""
    var standard:String = ""
    
    @IBOutlet weak var targetCoin: UILabel!
    @IBOutlet weak var CoinRate: UILabel!
    @IBOutlet weak var standardCoin: UILabel!

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        targetCoin.text = target
        CoinRate.text = rate
        standardCoin.text = standard
    }
    @IBAction func returnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
