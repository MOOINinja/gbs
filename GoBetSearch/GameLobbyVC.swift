//
//  GameLobbyVC.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-17.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class GameLobbyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellRows = ["Leader board Header","Leader board", "New games Header", "New games", "All Games Header","All games"]
    
    let leaderHeaderCellID = "leaderHeaderCellID"
    let leaderBoardCollectionCellID = "leaderBoardColletionCellID"
    
    let gameHeaderCellID = "gameHeaderCellID"
    let gameCollectionCellID = "gameCollectionCellID"
    
    let allGamesHeaderCellID = "allGamesHeaderCellID"
    let allGamesCollectionCellID = "allGamesCollectionCellID"
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = false
        return view
    }()
    
    var containerView = UIView()
    var topBar = UIView()
    
    let logoTopBar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo-top")
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = UIColor.rgb(red: 40, green: 40, blue: 40, alpha: 1)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        view.separatorStyle = UITableViewCellSeparatorStyle.none
        //view.allowsSelection = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 53, green: 53, blue: 53, alpha: 1)
        hideNavigationBar()
        setupContentsViews()
        registerCell()
        
    }
    
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupContentsViews() {
        view.addSubview(topBar)
        view.addSubview(logoTopBar)
        view.addSubview(tableView)
        
        topBar.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
        topBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        
        logoTopBar.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 141, height: 16)
        logoTopBar.centerXAnchor.constraint(equalTo: topBar.centerXAnchor).isActive = true
        logoTopBar.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        
        tableView.anchor(top: topBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func registerCell() {
        
        tableView.register(LeaderBoardHeaderCell.self, forCellReuseIdentifier: leaderHeaderCellID)
        tableView.register(LeaderBoardCollectionViewCell.self, forCellReuseIdentifier: leaderBoardCollectionCellID)
        
        tableView.register(GameHeaderCell.self, forCellReuseIdentifier: gameHeaderCellID)
        tableView.register(GameCollectionViewCell.self, forCellReuseIdentifier: gameCollectionCellID)
        
        tableView.register(AllGamesHeaderCell.self, forCellReuseIdentifier: allGamesHeaderCellID)
        tableView.register(AllGamesCollectionViewCell.self, forCellReuseIdentifier: allGamesCollectionCellID)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: leaderHeaderCellID, for: indexPath) as! LeaderBoardHeaderCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: leaderBoardCollectionCellID, for: indexPath) as! LeaderBoardCollectionViewCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: gameHeaderCellID, for: indexPath) as! GameHeaderCell
            cell.allLabel.isHidden = true
            cell.arrowIcon.isHidden = true
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: gameCollectionCellID, for: indexPath) as! GameCollectionViewCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: allGamesHeaderCellID, for: indexPath) as! AllGamesHeaderCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: allGamesCollectionCellID, for: indexPath) as! AllGamesCollectionViewCell
            cell.backgroundColor = UIColor.rgb(red: 40, green: 40, blue: 40, alpha: 1)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        }
        if indexPath.row == 1 {
            return 210
        }
        if indexPath.row == 2 {
            return 35
        }
        if indexPath.row == 3 {
            return 100
        }
        if indexPath.row == 4 {
            return 40
        }
        if indexPath.row == 5 {
            
            let cell = AllGamesCollectionViewCell()
            
            let count = cell.allGamesArray.count
            let height = Int(count / 3) * 80 + 160
 
            return CGFloat(height)
        }
        return 0
    }
    
    
    
    
    
    
}
