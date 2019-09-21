//
//  MemeF.swift
//  MeMe.
//
//  Created by نورة . on 07/09/2019.
//  Copyright © 2019 نورة . All rights reserved.
//

import Foundation
import UIKit

//MARK : Create Memem struct .
struct Meme {
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    // Constructor
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}

