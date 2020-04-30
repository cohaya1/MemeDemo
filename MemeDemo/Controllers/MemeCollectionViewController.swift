//
//  MemeCollectionViewController.swift
//  MemeDemo
//
//  Created by Makaveli Ohaya on 4/4/20.
//  Copyright © 2020 Ohaya. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        collectionView?.reloadData()
        navigationItem.title = "Sent Memes Collection View"
        collectionView?.backgroundColor = UIColor.lightGray
    }
    override func viewDidAppear(_ animated: Bool) {
           collectionView!.reloadData()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    FlowlayoutCells()
        // Register cell classes
    //    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectCell")

        // Do any additional setup after loading the view.
   let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space)) / 3.0

            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        }
    struct Constants {
        static let CellVerticalSpacing: CGFloat = 2
    }
    func FlowlayoutCells() {
        // set device flow layout based on the horizontal orientation
           var FlowlayoutcellWidth: CGFloat
           var numWide: CGFloat
           
           
        switch UIDevice.current.orientation {
        case .portrait:
               numWide = 3
        case .portraitUpsideDown:
               numWide = 3
        case .landscapeLeft:
               numWide = 4
        case .landscapeRight:
               numWide = 4
           default:
               numWide = 4
           }
        FlowlayoutcellWidth = collectionView!.frame.width / numWide
        
        //updates the cell width to account for the desired cell spacing (a predetermined constant, defined in the Constants struct), then updates the itemSize accordingly
        FlowlayoutcellWidth -= Constants.CellVerticalSpacing
        flowLayout.itemSize.width = FlowlayoutcellWidth
        flowLayout.itemSize.height = FlowlayoutcellWidth
        flowLayout.minimumInteritemSpacing = Constants.CellVerticalSpacing
        
        //calculates the actual vertical spacing between cells, accounting for the additional vertical space that was subtracted from the cell width (e.g. if there are 3 cells, there are only 2 vertical spaces, not 3); then by setting the line spacing to be equal to this "actual" value, the vertical and horizontal distances between cells should be exact (or as close to exact as possible)
        let actualCellVerticalSpacing: CGFloat = (collectionView!.frame.width - (numWide * FlowlayoutcellWidth))/(numWide - 1)
        flowLayout.minimumLineSpacing = actualCellVerticalSpacing
        
        //causes the collection view to invalidate its current layout and relay out the collection view using the new settings in the flow layout (without this call, the cells don't properly resize upon rotation)
        flowLayout.invalidateLayout()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
return self.memes.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath) as! SentMemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        cell.MemeCollectionimage.image  = meme.memedImage
        
        // Configure the cell
    
        return cell
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetail" {
                let memeDetailVC = segue.destination as! MemeDetailsViewController
                let meme = sender as! Meme
                memeDetailVC.meme = meme
            }
        }
 
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
     //Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
        detailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
        return true
    }
    
}
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


