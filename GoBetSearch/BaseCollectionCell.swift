//
//  BaseCollectionCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-16.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
