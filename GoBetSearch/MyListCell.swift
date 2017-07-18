//
//  MyListCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-17.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class MyListCell: BaseTableCell {
    
    // ==============================
    // First game and Time - (gameLabel)
    //
    // ==============================
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        //label.textColor = UIColor.rgb(red: 0, green: 150, blue: 129, alpha: 1)
        return label
    }()
    
    let bellIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bell_tranpart")
        return view
    }()
    
    let arrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "gbs_arrow")
        return view
    }()
    
    let gameLabel: UILabel = {
        let label = UILabel()
        label.text = "17:11 - 19:20 Football"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        //label.textColor = UIColor.rgb(red: 0, green: 150, blue: 129, alpha: 1)
        label.textColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.clear
        setupContents()
    }
    
    func setupContents() {
        addSubview(view)
        addSubview(titleLabel)
        addSubview(gameLabel)
        addSubview(bellIcon)
        addSubview(arrowIcon)
        
        view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
        
        titleLabel.anchor(top: view.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 60, height: 16)
        
        bellIcon.anchor(top: view.topAnchor, left: titleLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        gameLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 280, height: 16)
        
        arrowIcon.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 8, height: 13)
        arrowIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
    }
}
