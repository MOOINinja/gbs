//
//  LeaderBoardPlayerListCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-18.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class LeaderBoardPlayerListCell: BaseTableCell {
    
    // ==============================
    // Rank
    // Username
    // Chip won
    // Score
    // - (skip title labels) -
    // ==============================
    
    // Check constraints!!!
    
    let rankTitle: UILabel = {
        let label = UILabel()
        label.text = "#"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        return label
    }()
    
    let playerTitle: UILabel = {
        let label = UILabel()
        label.text = "Player"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        return label
    }()
    
    let chipTitle: UILabel = {
        let label = UILabel()
        label.text = "Chip won"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        return label
    }()
    
    let scoreTitle: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        return label
    }()
    
    let rankNumber: UILabel = {
        let label = UILabel()
        label.text = "#1."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 160, green: 160, blue: 160, alpha: 1)
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@username"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 160, green: 160, blue: 160, alpha: 1)
        return label
    }()
    
    let chipNumber: UILabel = {
        let label = UILabel()
        label.text = "250"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 255, green: 230, blue: 37, alpha: 1)
        return label
    }()
    
    let scoreNumber: UILabel = {
        let label = UILabel()
        label.text = "1903"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textColor = UIColor.rgb(red: 160, green: 160, blue: 160, alpha: 1)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.rgb(red: 56, green: 56, blue: 56, alpha: 1)
    }
    
    func setupContents() {
        addSubview(rankNumber)
        addSubview(usernameLabel)
        addSubview(chipNumber)
        addSubview(scoreNumber)
    
        rankNumber.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 22, height: 16)
        rankNumber.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        usernameLabel.anchor(top: nil, left: rankNumber.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 160, height: 16)
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        scoreNumber.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 42, height: 16)
        scoreNumber.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        chipNumber.anchor(top: nil, left: nil, bottom: nil, right: scoreNumber.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 66, height: 16)
        chipNumber.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
    func titleContents() {
        addSubview(rankTitle)
        addSubview(playerTitle)
        addSubview(chipTitle)
        addSubview(scoreTitle)
        
        rankTitle.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 22, height: 16)
        rankTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        playerTitle.anchor(top: nil, left: rankTitle.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 160, height: 16)
        playerTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        scoreTitle.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 42, height: 16)
        scoreTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        chipTitle.anchor(top: nil, left: nil, bottom: nil, right: scoreTitle.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 66, height: 16)
        chipTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
}
