//
//  MainViewController.swift
//  WalletCardAdder
//
//  Created by Jin-MackBookPro15 on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("hello world")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func goToHistodyAction(_ sender: Any) {
        let vc = HistoryViewController.init(nibName: "HistoryViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addCardAction(_ sender: Any) {
        let vc = TrmplateSelectViewController.init(nibName: "TrmplateSelectViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
}
