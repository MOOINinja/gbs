//
//  HomeVC.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-16.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellRows = ["Top Event","My List" , "Offer Header", "Offers", "Game Header", "Games"]
    
    let topEventCellID = "topEventCellID"
    
    let myListCellID = "myListCellID"
    
    let offerHeaderCellID = "offerHeaderCellID"
    let offerCollectionCellID = "offerCollectionCellID"
    
    let gameHeaderCellID = "gameHeaderCellID"
    let gameCollectionCellID = "gameCollectionCellID"
    
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
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 53, green: 53, blue: 53, alpha: 1)
        hideNavigationBar()
        setupScrollView()
        setupContentsViews()
        registerCell()
        
        checkDeviceType()
    }
    
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x:0, y:0, width:scrollView.contentSize.width, height:scrollView.contentSize.height)
    }
 
    
    func setupScrollView() {
        view.addSubview(scrollView)
        self.scrollView.delegate = self
        let width = view.bounds.width
        let height = view.bounds.height
        self.scrollView.contentSize = CGSize(width: width, height: 1000)
        
        containerView = UIView()
        
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
    }
    
    func checkDeviceType() {
        if DeviceType.IS_IPAD {
            print("\n\n IPAD !!\n\n")
        }
        if DeviceType.IS_IPHONE_5 {
            print("\n\n iPhone 5 !!\n\n")
            scrollView.isScrollEnabled = true
        }
        
        if DeviceType.IS_IPHONE_6{
            print("\n\n iPhone 6\n\n")
        }
        
        if DeviceType.IS_IPHONE_7{
            print("\n\n iPhone 7\n\n")
        }
        
        if DeviceType.IS_IPHONE_7P{
            print("\n\n iPhone 7plus\n\n")
            scrollView.isScrollEnabled = false
        }
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
        
        tableView.register(TopEventCell.self, forCellReuseIdentifier: topEventCellID)
        
        tableView.register(MyListCell.self, forCellReuseIdentifier: myListCellID)
        
        tableView.register(OfferHeaderCell.self, forCellReuseIdentifier: offerHeaderCellID)
        tableView.register(OfferCollectionViewCell.self, forCellReuseIdentifier: offerCollectionCellID)
        
        tableView.register(GameHeaderCell.self, forCellReuseIdentifier: gameHeaderCellID)
        tableView.register(GameCollectionViewCell.self, forCellReuseIdentifier: gameCollectionCellID)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: topEventCellID, for: indexPath) as! TopEventCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: myListCellID, for: indexPath) as! MyListCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 2 {
        let cell = tableView.dequeueReusableCell(withIdentifier: offerHeaderCellID, for: indexPath) as! OfferHeaderCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: offerCollectionCellID, for: indexPath) as! OfferCollectionViewCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: gameHeaderCellID, for: indexPath) as! GameHeaderCell
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: gameCollectionCellID, for: indexPath) as! GameCollectionViewCell
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        }
        if indexPath.row == 1 {
            return 60
        }
        if indexPath.row == 2 {
            return 30
        }
        if indexPath.row == 3 {
            return 110
        }
        if indexPath.row == 4 {
            return 35
        }
        if indexPath.row == 5 {
            return 100
        }
        return 0
    }
    
   
   
    
    
}
