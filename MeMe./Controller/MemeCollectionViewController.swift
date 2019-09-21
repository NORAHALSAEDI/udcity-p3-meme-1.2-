//
//  MemeCollectionViewController.swift
//  MeMe.
//
//  Created by نورة . on 07/09/2019.
//  Copyright © 2019 نورة . All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayouot: UICollectionViewFlowLayout!
      // MARK:Collection View Data Source
    var meme: [Meme] {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayouot.minimumInteritemSpacing = space
        flowLayouot.minimumLineSpacing = space
        flowLayouot.itemSize = CGSize(width: dimension, height: dimension)
    }
      // MARK: Update Data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.collectionView.reloadData()
    }
    
    
    // MARK: func of number of item
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.meme.count
    }
    
    //func of number of item 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeC", for: indexPath) as! CollectionViewCell
        let memes = meme[indexPath.row]
        memeCell.imageViwe.image = memes.memedImage
        return memeCell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailMemeController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailMemeController.ememe = meme[indexPath.row]
        self.navigationController?.pushViewController(detailMemeController, animated: true)
    }

    
    
    
    
    
    
    
    
}
