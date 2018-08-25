//
//  TrmplateSelectViewController.swift
//  WalletCardAdder
//
//  Created by byongguen son on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import UIKit

class TrmplateSelectViewController: UIViewController,UICollectionViewDataSource {
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Internal Variables
    private let reUseIdentifier = "cardCell"
    let cardList: [String] = [
        "red",
        "yellow",
        "green",
        "blue"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.register(TemplateCollectionViewCell.self, forCellWithReuseIdentifier: self.reUseIdentifier)
        collectionView.register(UINib(nibName: "TemplateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.reUseIdentifier)
        self.collectionView.isPagingEnabled = true
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0,0)
            flowLayout.itemSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionView DataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reUseIdentifier, for: indexPath) as! TemplateCollectionViewCell
        cell.imageView.image = UIImage(named: self.cardList[indexPath.item])
        return cell
    }
    // MARK: Button Actions
    @IBAction func selectTemplate(_ sender: UIButton) {
        let selectedCard = self.cardList[collectionView.indexPathsForVisibleItems[0][1]]
        var vc: UIViewController!
        switch selectedCard {
        case "red":
            vc = RedCardViewController.init(nibName: "RedCardViewController", bundle: nil)
        case "green":
            vc = GreenCardViewController.init(nibName: "GreenCardViewController", bundle: nil)
        default:
            vc = AddInformationViewController.init(nibName: "AddInformationViewController", bundle: nil)
        }
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
       
    }
}
