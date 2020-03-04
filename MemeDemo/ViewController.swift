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
    
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var TopToolbar: UIToolbar!
    
    @IBOutlet weak var BottomToolbar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    var memedImage = UIImage()
      var meme:Meme!
    var selectedTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textLoad()
    }
    func textLoad (){
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
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
           let userInfo = notification.userInfo
           let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
           return keyboardSize.cgRectValue.height
       }
       
      func subscribeToKeyboardNotifications() {
       NotificationCenter.default.addObserver(
       self,
       selector: #selector(self.keyboardWillShow(notification:)),
       name: UIResponder.keyboardDidShowNotification, object: nil)
        
       }
       
       @objc func keyboardWillShow(notification: Notification) {
           if let text = selectedTextField {
               if text == bottomTextField {
                   self.view.frame.origin.y = -getKeyboardHeight(notification: notification as NSNotification)
               }
           }
       }
       
       func keyboardWillHide(notification: NSNotification) {
           self.view.frame.origin.y = 0
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
           selectedTextField = nil
           if textField == topTextField && textField.text! == "" {
               textField.text = "TOP TEXT"
           }
           if textField == bottomTextField && textField.text! == "" {
               textField.text = "BOTTOM TEXT"
           }
       }

       func unsubscribeFromKeyBoardNotifications() {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
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
           
           selectedTextField = textField
           if textField.text == "TOP" || textField.text == "BOTTOM" {
               textField.text = ""
           }
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    @IBAction func Sharebutton(_ sender: Any) {
        shareMeme()
    }
    func save(memedImage: UIImage) {
           let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image, memedImage: memedImage)
           self.meme = meme
           (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
       }
       
       func shareMeme() {
           let memeToShare = generateMemedImage()
           let activity = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
           activity.completionWithItemsHandler = { (activity, success, items, error) in
               
               if success {
                   self.save(memedImage: memeToShare)
               }
           }
           present(activity, animated: true, completion:nil)
       }
    func generateMemedImage() -> UIImage {
        
        hideControls()

        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        showControls()
                
        return memedImage
    }
    
    func hideControls() {
        for view in self.view.subviews as [UIView] {
            if let button = view as? UIButton {
                button.isHidden = true
            }
        }
    }
    
    func showControls() {
        for view in self.view.subviews as [UIView] {
            if let button = view as? UIButton {
                button.isHidden = false
            }
        }
    }
    func UIImageWriteToSavedPhotosAlbum(_ image: UIImage,_ completionTarget: Any?,_ completionSelector: Selector?,_ contextInfo: UnsafeMutableRawPointer?) {
        
    }
    
}
