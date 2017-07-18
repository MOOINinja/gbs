//
//  LeaderBoardHeaderCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-18.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class LeaderBoardHeaderCell: BaseTableCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Leader Board"
        label.textAlignment = .center
        label.textColor = UIColor.rgb(red: 230, green: 230, blue: 230, alpha: 1)
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Most popular games"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 160, green: 160, blue: 160, alpha: 1)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.rgb(red: 56, green: 56, blue: 56, alpha: 1)
        setupContents()
    }
    
    func setupContents() {
        
        addSubview(titleLabel)
        addSubview(infoLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        infoLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 16)
        
    }
}
