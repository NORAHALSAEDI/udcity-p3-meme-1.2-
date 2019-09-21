//
//  MemeaTbleViewController.swift
//  MeMe.
//
//  Created by نورة . on 07/09/2019.
//  Copyright © 2019 نورة . All rights reserved.
//

import UIKit

class MemeaTbleViewController: UITableViewController {
    
    // MARK: Table View Data Source
    var meme: [Meme] {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.memes
    }
    
    // MARK: Update Data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //func of number of row fection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meme.count
    }
    
    //func of send or store data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeCell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeTableViewCell
        let memes = meme[indexPath.row]
        memeCell.textLabel?.text = "\(memes.bottomText)......\(memes.bottomText)/"
        memeCell.imageView?.image = memes.memedImage
        
        return memeCell
    }
    
    // func of select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailMemeController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailMemeController.ememe = meme[indexPath.row]
        self.navigationController?.pushViewController(detailMemeController, animated: true)
        
    }
    
    
   
    
    
}

