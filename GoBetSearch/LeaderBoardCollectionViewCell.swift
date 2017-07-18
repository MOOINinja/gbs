//
//  LeaderBoardCell.swift
//  GoBetSearch
//
//  Created by Chibi Anward on 2017-07-18.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

class LeaderBoardCollectionViewCell: BaseTableCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let cellID = "cellID"
    
    let leaderBoardArray = ["1", "2", "3", "4"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 56, green: 56, blue: 56, alpha: 1)
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        return control
    }()
    
    override func setupViews() {
        super.setupViews()
    
        pageControl.numberOfPages = leaderBoardArray.count
        setupContents()
        registerCell()
    }
    
    func setupContents() {
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        pageControl.anchor(top: nil, left: leftAnchor, bottom: collectionView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 0, width: 0, height: 10)
        
    }
    
    func registerCell() {
        collectionView.register(LeaderBoardCardCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leaderBoardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! LeaderBoardCardCell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   /*
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    */
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / max(1, collectionView.frame.width)
        print("\(pageNumber)")
        
        pageControl.currentPage = Int(pageNumber)
        
        

    }
    
}
