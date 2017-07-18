//
//  AllGamesHeaderCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-18.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class AllGamesHeaderCell: BaseTableCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "All games"
        label.textColor = UIColor.rgb(red: 230, green: 230, blue: 230, alpha: 1)
        return label
    }()
    
    let arrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "default_arrow")
        return view
    }()
    
    let allLabel: UILabel = {
        let label = UILabel()
        label.text = "All games"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.rgb(red: 180, green: 180, blue: 180, alpha: 1)
        label.textAlignment = .right
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.rgb(red: 40, green: 40, blue: 40, alpha: 1)
        setupContents()
    }
    
    func setupContents() {
        
        addSubview(titleLabel)
        //addSubview(arrowIcon)
        //addSubview(allLabel)
        
        titleLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 200, height: 20)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        /*
        arrowIcon.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 8, height: 13)
        arrowIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        allLabel.anchor(top: nil, left: nil, bottom: nil, right: arrowIcon.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 80, height: 16)
        allLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
 */
    }
}
