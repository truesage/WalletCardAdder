//
//  GreenCardViewController.swift
//  WalletCardAdder
//
//  Created by byongguen son on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

import UIKit

class GreenCardViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var logoImageView: UIButton!
    
    @IBOutlet weak var titleContainerImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceSubLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var barcodeImageView: UIImageView!
//    @IBOutlet weak var dateLabel: UILabel!
    
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.priceLabel.isUserInteractionEnabled = true
        self.priceSubLabel.isUserInteractionEnabled = true
        
        self.contentTitleLabel.isUserInteractionEnabled = true
        self.contentLabel.isUserInteractionEnabled = true
        self.productNameLabel.isUserInteractionEnabled = true
        self.priceLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePrice)))
        self.priceSubLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePriceSub)))
        self.contentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeContent)))
        self.contentTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeContentTitle)))
        self.productNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeProductName)))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
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
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                
                self.barcodeImageView.image =  UIImage(ciImage: output)
            }
        }
    }
    @IBAction func addLogoImage(_ sender: UIButton) {
        
    }
    
    @IBAction func addCardAction(_ sender: UIButton) {
    }
    @objc func changePrice(){
        self.getChangedText(priceLabel)
    }
    @objc func changePriceSub(){
        self.getChangedText(priceSubLabel)
    }
    @objc func changeProductName(){
     self.getChangedText(productNameLabel)
    }
    @objc func changeContent(){
        self.getChangedText(contentLabel)
    }
    @objc func changeContentTitle(){
        self.getChangedText(contentTitleLabel)
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
