//
//  ImageView.swift
//  MeMe.
//
//  Created by نورة . on 05/09/2019.
//  Copyright © 2019 نورة . All rights reserved.
//

import UIKit
@IBDesignable
class ImageView:UIImageView {
 
    
    @IBInspectable var BorderWidth :CGFloat = 0 {
        didSet{
            self.layer.borderWidth = BorderWidth
            
        }
    }
    
    @IBInspectable var BorderColoer :UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColoer.cgColor
            
        }
    }
    
    @IBInspectable var FirstColor:UIColor=UIColor.clear{
        didSet{
            UpdateView()
        }
    }
    
    @IBInspectable var SecondColor:UIColor=UIColor.clear{
        didSet{
            UpdateView()
        }
    }
    
    override class var layerClass:AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    
    @IBInspectable var CornerRaduis :CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = CornerRaduis
            
        }
    }
    
    
    
    override func layoutSubviews() {
        super .layoutSubviews()
        self.clipsToBounds = true
    }
    
    func  UpdateView (){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor,SecondColor.cgColor]
    }
    
}


    

