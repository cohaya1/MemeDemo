//
//  MemeDetailsViewController.swift
//  MemeDemo
//
//  Created by Makaveli Ohaya on 4/22/20.
//  Copyright © 2020 Ohaya. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    // var meme: Meme! = nil
    var meme:Meme?
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var cancelButton: UIBarButtonItem!
        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)  // added per instructor
        imageView.image = meme?.memedImage
        
               if let newImage = meme?.memedImage {
                   imageView.image = newImage
               }
        }
        
        @IBAction func cancelAction(sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)    // removed self
        }
        
         func prefersStatusBarHidden() -> Bool {
            return true     // status bar should be hidden
        }
    }
