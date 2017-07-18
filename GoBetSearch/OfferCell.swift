//
//  OfferCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-17.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class OfferCell: BaseCollectionCell {
    
    // ==============================
    // Image
    // ==============================
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "offer_1")
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        //backgroundColor = UIColor.rgb(red: 60, green: 200, blue: 200, alpha: 1)
        setupContents()
    }
    
    func setupContents() {
        
         addSubview(contentImageView)
         contentImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
 
        
    }

    
}
