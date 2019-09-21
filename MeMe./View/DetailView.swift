//
//  DetailView.swift
//  MeMe.
//
//  Created by نورة . on 07/09/2019.
//  Copyright © 2019 نورة . All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController {
    
@IBOutlet weak var memeImage: UIImageView!
var ememe:Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        title = "View"
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImage.image = ememe.memedImage
         tabBarController?.tabBar.isHidden = true
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    
}
