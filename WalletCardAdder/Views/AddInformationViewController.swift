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
    let picker = UIImagePickerController()
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subTitleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
    }
    @IBAction func addBarcodeImageAction(_ sender: UIButton) {
        self.present(self.picker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.getBarcodeFromImage(image)
    }
    func getBarcodeFromImage(_ image: UIImage){
        if #available(iOS 11.0, *) {
            let barcodeRequest = VNDetectBarcodesRequest(completionHandler: { request, error in
                
                guard let results = request.results else { return }
                
                // Loopm through the found results
                for result in results {
                    
                    // Cast the result to a barcode-observation
                    if let barcode = result as? VNBarcodeObservation {
                        
                        // Print barcode-values
                        print("Symbology: \(barcode.symbology.rawValue)")
                        
                        if let desc = barcode.barcodeDescriptor as? CIQRCodeDescriptor {
                            let content = String(data: desc.errorCorrectedPayload, encoding: .utf8)
                            
                            // FIXME: This currently returns nil. I did not find any docs on how to encode the data properly so far.
                            print("Payload: \(String(describing: content))")
                            print("Error-Correction-Level: \(desc.errorCorrectionLevel)")
                            print("Symbol-Version: \(desc.symbolVersion)")
                        }
                    }
                }
            })
            // Create an image handler and use the CGImage your UIImage instance.
            guard let image = image.cgImage else { return }
            let handler = VNImageRequestHandler(cgImage: image, options: [:])
            
            // Perform the barcode-request. This will call the completion-handler of the barcode-request.
            guard let _ = try? handler.perform([barcodeRequest]) else {
                return print("Could not perform barcode-request!")
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    @IBAction func addCardAction(_ sender: UIButton) {
    }
    
}
@available(iOS 11.0, *)
extension AddInformationViewController{
   
}
