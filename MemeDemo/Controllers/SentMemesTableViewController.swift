//
//  SentMemesTableViewController.swift
//  MemeDemo
//
//  Created by Makaveli Ohaya on 4/2/20.
//  Copyright © 2020 Ohaya. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController,UIViewControllerTransitioningDelegate {

    @IBOutlet var addmeme : UIBarButtonItem!
    
    
 var memes: [Meme]! {
     let object = UIApplication.shared.delegate
     let appDelegate = object as! AppDelegate
     return appDelegate.memes
 }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
         self.tableView.dataSource = self
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      // removed self
        
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! SentMemeTableViewCell
        
                // Configure the cell...
        let meme = self.memes[indexPath.row]
        cell.TopandBottomTextLabel.text =  "\(meme.topText) ... \(meme.bottomText)"
       
        cell.thumbnailImageView.image = meme.memedImage
        

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
                      detailViewController.meme = self.memes[indexPath.row]
                      self.navigationController!.pushViewController(detailViewController, animated: true)
                      
           }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowEditScreen" {
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destination as! ViewController
            destinationController.meme = memes[indexPath.row]
            
        }
        
       
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

        
   /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
*/
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
}
