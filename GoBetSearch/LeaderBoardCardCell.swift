//
//  LeaderBoardCardCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-18.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class LeaderBoardCardCell: BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    let playerList = ["header cell","player1", "player2", "player3", "player4"]
    
    let cellID = "cellID"
    let headerCellID = "headerCellID"
    
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "leaderBoard_gameIcon_dice")
        return imageView
    }()
    
    let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dice"
        label.textAlignment = .left
        label.textColor = UIColor.rgb(red: 230, green: 230, blue: 230, alpha: 1)
        return label
    }()
    
    let playBtn: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "leaderBoard_playBtn")
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = UIColor.rgb(red: 56, green: 56, blue: 56, alpha: 1)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = false
        view.separatorStyle = UITableViewCellSeparatorStyle.none
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.rgb(red: 56, green: 56, blue: 56, alpha: 1)
        registerCell()
        setupContents()
    }
    
    func setupContents() {
        addSubview(gameImageView)
        addSubview(gameTitleLabel)
        addSubview(playBtn)
        addSubview(tableView)
        
        gameImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        
        gameTitleLabel.anchor(top: nil, left: gameImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 280, height: 16)
        gameTitleLabel.centerYAnchor.constraint(equalTo: gameImageView.centerYAnchor).isActive = true
        
        playBtn.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 28, width: 80, height: 30)
        
        tableView.anchor(top: gameImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 28, paddingBottom: 6, paddingRight: 28, width: 0, height: 0)
    }
    
    func registerCell() {
        tableView.register(LeaderBoardPlayerListCell.self, forCellReuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LeaderBoardPlayerListCell
            cell.titleContents()
            cell.selectionStyle = .none
        return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LeaderBoardPlayerListCell
        cell.setupContents()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 28
        }
        return 32
    }
    
}
