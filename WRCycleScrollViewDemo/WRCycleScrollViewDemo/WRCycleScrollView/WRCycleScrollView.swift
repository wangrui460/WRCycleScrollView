//
//  WRCycleScrollView.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

enum ImagesType:Int {
    case SERVER = 0
    case LOCAL = 1
}

class WRCycleScrollView: UIView
{
    fileprivate var collectionView:UICollectionView!
    fileprivate let CellID = "WRCycleCell"
    var localImgArray:[String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(frame: CGRect, imgArray:[String]? = nil)
    {
        super.init(frame: frame)
        if let local = imgArray {
            localImgArray = local
        }
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WRCycleScrollView---deinit")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // 解决WRCycleCell自动偏移问题
        collectionView.contentInset = .zero
    }
}


// MARK: - collectionView
extension WRCycleScrollView: UICollectionViewDelegate,UICollectionViewDataSource
{
    func setupCollectionView()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.register(WRCycleCell.self, forCellWithReuseIdentifier: CellID)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return localImgArray?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! WRCycleCell
        cell.localImgPath = localImgArray?[indexPath.item]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
}


