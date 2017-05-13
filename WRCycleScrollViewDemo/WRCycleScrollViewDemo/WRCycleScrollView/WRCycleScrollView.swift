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
    ///////////////////////////////////////////////////////
    // 对外提供的属性
    var imgsType:ImagesType = .SERVER     // default SERVER
    var localImgArray:[String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var serverImgArray:[String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var descTextArray:[String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    ///////////////////////////////////////////////////////
    // 内部属性
    fileprivate var flowLayout:UICollectionViewFlowLayout!
    fileprivate var collectionView:UICollectionView!
    fileprivate let CellID = "WRCycleCell"
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - type:  ImagesType                         default:Server
    ///   - imgs:  localImgArray / serverImgArray     default:nil
    ///   - descs: descTextArray                      default:nil
    init(frame: CGRect, type:ImagesType = .SERVER, imgs:[String]? = nil, descs:[String]? = nil)
    {
        super.init(frame: frame)
        imgsType = type
        if imgsType == .SERVER
        {
            if let server = imgs {
                serverImgArray = server
            }
        }
        else
        {
            if let local = imgs {
                localImgArray = local
            }
        }
        if let descTexts = descs {
            descTextArray = descTexts
        }
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WRCycleScrollView  deinit")
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
        flowLayout = UICollectionViewFlowLayout()
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
        if imgsType == .SERVER {
            return serverImgArray?.count ?? 0
        } else {
            return localImgArray?.count ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let curItem = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! WRCycleCell
        cell.descText = descTextArray?[curItem]
        
        if imgsType == .SERVER {
            cell.serverImgPath = serverImgArray?[curItem]
        } else {
            cell.localImgPath = localImgArray?[curItem]
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
}


