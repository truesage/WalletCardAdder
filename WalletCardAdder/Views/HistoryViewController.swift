//
//  HistoryViewController.swift
//  WalletCardAdder
//
//  Created by byongguen son on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: Internal Variables
    let reUseIdentifier : String = "historyCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: self.reUseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reUseIdentifier) as! HistoryTableViewCell
        cell.titleLabel.text = "Title"
        cell.subTitleLabel.text = "SubTitle"
        cell.expireDateLabel.text = "ExpireDate"
        cell.typeLabel.text = "Red"
        return cell
    }
    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row % 3
        var vc: UIViewController!
        switch row {
        case 0:
            vc = RedCardViewController.init(nibName: "RedCardViewController", bundle: nil)
        case 1:
            vc = GreenCardViewController.init(nibName: "GreenCardViewController", bundle: nil)
        case 2:
            vc = AddInformationViewController.init(nibName: "AddInformationViewController", bundle: nil)
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
