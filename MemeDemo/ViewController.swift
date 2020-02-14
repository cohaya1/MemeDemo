//
//  ViewController.swift
//  MemeDemo
//
//  Created by Makaveli Ohaya on 2/9/20.
//  Copyright © 2020 Ohaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    weak var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    var SelectedTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
    bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.center
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
   let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor:UIColor.white,
       NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:-3
    ]
    override func viewWillAppear(_ animated: Bool) {
        CameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        
        if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
           

        }
        dismiss(animated: true, completion: nil)
    
    }
   @IBAction func pickAnImageFromCamera(_ sender: Any) {

       let imagePicker = UIImagePickerController()
       imagePicker.delegate = self
   imagePicker.sourceType = .camera
       present(imagePicker, animated: true, completion: nil)
   }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
      }
    func textFieldDidBeginEditing(_ textField: UITextField) {
           
           SelectedTextField = textField
           if textField.text == "TOP" || textField.text == "BOTTOM" {
               textField.text = ""
           }
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func UIImageWriteToSavedPhotosAlbum(_ image: UIImage,_ completionTarget: Any?,_ completionSelector: Selector?,_ contextInfo: UnsafeMutableRawPointer?) {
        
    }
    
}
