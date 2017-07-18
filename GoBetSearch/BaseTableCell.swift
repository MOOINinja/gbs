//
//  BaseTableCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-16.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
