//
//  ViewController.swift
//  CoinAPI
//
//  Created by 王佩豪 on 2023/12/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var targetCoinField: UITextField!
    
    
    var coinApiManager = CoinApiManager()
    var target = ""
    var rate = ""
    var standard = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinApiManager.delegate = self
        targetCoinField.delegate = self  
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        targetCoinField.text = ""
        self.performSegue(withIdentifier: "searchToResult", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToResult"{
            let destinationVC = segue.destination as! CoinViewController
            destinationVC.rate = rate
            destinationVC.target = target
            destinationVC.standard = standard
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        targetCoinField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(targetCoinField.text != ""){
            return true
        }else{
            targetCoinField.placeholder="!!!"
            return false
        }
    }
    
    //实际上是在这里进行api调用
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let target = targetCoinField.text{
            coinApiManager.fetchCoinRate(target:target)
        }
    }
}


//MARK: - CoinApiManagerDelegate
extension ViewController: CoinApiManagerDlegate {
    // 此函数使用WeatherManager传回的数据修改页面上展示的内容
    func didUpdateRate(_ coinApiManager:CoinApiManager, coinModel:CoinModel){
        DispatchQueue.main.async {
            //更新主页内容
//            self.appTitle.text = "I Get it"
            self.rate = coinModel.coinRateString
            self.target = coinModel.coinTarget
            self.standard = coinModel.coinStandard
//            self.appTitle.text =
        }
    }
    //返回错误函数
    func didFailWithError(error: Error) {
        print(error)
    }
}
