//
//  AddInformationViewController.swift
//  WalletCardAdder
//
//  Created by byongguen son on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import UIKit
import Vision
class AddInformationViewController : UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var subContentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconCollectionView: UICollectionView!
    // MARK: Internal Variables
    
    let picker = UIImagePickerController()
    let reUseIdentifier = "iconCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        iconCollectionView.register(UINib(nibName: "IconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.reUseIdentifier)
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        self.contentLabel.isUserInteractionEnabled = true
        self.subContentLabel.isUserInteractionEnabled = true
        self.dateLabel.isUserInteractionEnabled = true
        self.contentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeContent)))
        self.subContentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changSubContent)))
        self.dateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeDate)))
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
            self.view.layoutIfNeeded()
        }
        if let flowLayout = self.iconCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let width = (UIScreen.main.bounds.width - 160) / 4
            let height = width
            flowLayout.itemSize = CGSize(width: width, height: height)
            flowLayout.minimumLineSpacing = 32
            flowLayout.minimumInteritemSpacing = 32
            flowLayout.sectionInset = UIEdgeInsetsMake(32, 32, 32, 32)
            
        }
    }
    @IBAction func iconCloseAction(_ sender: Any) {
        self.iconViewBottomConstraint.constant = -240
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func addBarcodeImageAction(_ sender: UIButton) {
        self.present(self.picker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.getBarcodeFromImage(image)
    }
    func getBarcodeFromImage(_ image: UIImage){
        
        let detector:CIDetector=CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        var decode=""
        let ciImage:CIImage = CIImage(image:image)!
        var qrCodeLink=""
        
        let features=detector.features(in: ciImage)
        for feature in features as! [CIQRCodeFeature] {
            qrCodeLink += feature.messageString!
        }
        print(qrCodeLink)
        let data = qrCodeLink.data(using: String.Encoding.ascii)
        //CIPDF417BarcodeGenerator
        //CICode128BarcodeGenerator
        //CICodeQRCodeGenerator
        if let filter = CIFilter(name: "CIPDF417BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                
                self.barcodeImageView.image =  UIImage(ciImage: output)
            }
        }
    }
    @IBAction func addLogoImage(_ sender: UIButton) {
        self.iconViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func addCardAction(_ sender: UIButton) {
        
    }
    @objc func changeDate(){
        self.getChangedText(dateLabel)
    }
    @objc func changeContent(){
         self.getChangedText(contentLabel)
    }
    @objc func changSubContent(){
         self.getChangedText(subContentLabel)
    }
    func getChangedText(_ label: UILabel){
        let alert = UIAlertController(title: "수정", message: "수정할 문자열을 입력하세요", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "문자열 입력"
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            label.text = (alert.textFields?.first?.text!)!
        }
        alert.addAction(okAction)
        self.present(alert,animated: true)
    }
    @IBAction func closeAction(){
        self.dismiss(animated: false, completion: nil)
    }
}
extension AddInformationViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reUseIdentifier, for: indexPath) as! IconCollectionViewCell
        cell.imageView.image = UIImage(named: "\(indexPath.row + 1)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.logoImageView.image = UIImage(named: "\(indexPath.row + 1)")
    }
}
