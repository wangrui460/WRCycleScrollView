//
//  WRCycleScrollView.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

enum ImagesType:Int {
    case SERVER = 0
    case LOCAL = 1
}

@objc protocol WRCycleScrollViewDelegate
{
    /// 点击图片回调
    @objc optional func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    /// 图片滚动回调
    @objc optional func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
}

class WRCycleScrollView: UIView
{
    ///////////////////////////////////////////////////////
    // 对外提供的属性
    weak var delegate:WRCycleScrollViewDelegate?
    
    var imgsType:ImagesType = .SERVER     // default SERVER
    var localImgArray :[String]?
    var serverImgArray:[String]?
    var descTextArray :[String]?
    
    override var frame: CGRect {
        didSet {
            flowLayout?.itemSize = frame.size
            collectionView?.frame = bounds
        }
    }
    
    var descLabelFont: UIFont?
    var descLabelTextColor: UIColor?
    var descLabelHeight: CGFloat?
    var descLabelTextAlignment:NSTextAlignment?
    var bottomViewBackgroundColor: UIColor?
    
    // 如果自动轮播，表示轮播间隔时间 default = 1.5s
    var autoScrollInterval: Double = 1.5
    var isEndlessScroll:Bool = true
    var isAutoScroll:Bool = true {
        didSet {
            timer?.invalidate()
            timer = nil
            if isAutoScroll == true {
                setupTimer()
            }
        }
    }
    
    ///////////////////////////////////////////////////////
    // 对外提供的方法
    func reloadData() {
        collectionView?.reloadData()
        changeToFirstCycleCell(animated: false)
    }
    
    
    ///////////////////////////////////////////////////////
    // 内部属性
    fileprivate var flowLayout:UICollectionViewFlowLayout?
    fileprivate var collectionView:UICollectionView?
    fileprivate let CellID = "WRCycleCell"
    
    fileprivate var timer:Timer?
    fileprivate var imgsCount:Int {
        if imgsType == .LOCAL {
            return localImgArray!.count
        } else {
            return serverImgArray!.count
        }
    }
    fileprivate var realItemCount:Int {
        if imgsType == .LOCAL {
            return (isEndlessScroll == true) ? localImgArray!.count * 128 : localImgArray!.count
        } else {
            return (isEndlessScroll == true) ? serverImgArray!.count * 128 : serverImgArray!.count
        }
    }
    
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
        if imgsType == .SERVER {
            if let server = imgs {
                serverImgArray = server
            }
        }
        else {
            if let local = imgs {
                localImgArray = local
            }
        }
        
        if let descTexts = descs {
            descTextArray = descTexts
        }
        setupCollectionView()
        if isAutoScroll == true {
            setupTimer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WRCycleScrollView  deinit")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 解决WRCycleCell自动偏移问题
        collectionView?.contentInset = .zero
        changeToFirstCycleCell(animated: false)
    }
    
    // 解决定时器导致的循环引用
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // 展现的时候newSuper不为nil，离开的时候newSuper为nil
        guard let _ = newSuperview else {
            timer?.invalidate()
            timer = nil
            return
        }
    }
}


// MARK: - 无限轮播相关
extension WRCycleScrollView
{
    func setupTimer()
    {
        timer = Timer(timeInterval: autoScrollInterval, target: self, selector: #selector(changeCycleCell), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func changeToFirstCycleCell(animated:Bool)
    {
        guard let collection = collectionView else {
            return
        }
        let item = (isEndlessScroll == true) ? (realItemCount / 2) : 0
        let indexPath = IndexPath(item: item, section: 0)
        collection.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: animated)
    }
    
    // 执行这个方法的前提是 isAutoScroll = true
    func changeCycleCell()
    {
        guard realItemCount  != 0 ,
              let collection = collectionView,
              let layout = flowLayout else {
            return
        }
        let curItem = Int(collection.contentOffset.x / layout.itemSize.width)
        if curItem == realItemCount - 1
        {
            let animated = (isEndlessScroll == true) ? false : true
            changeToFirstCycleCell(animated: animated)
        }
        else
        {
            let indexPath = IndexPath(item: curItem + 1, section: 0)
            collection.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isAutoScroll == true {
            setupTimer()
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        guard realItemCount  != 0 ,
            let collection = collectionView,
            let layout = flowLayout else {
                return
        }
        let curItem = Int(collection.contentOffset.x / layout.itemSize.width)
        let indexOnPageControl = curItem % imgsCount
        delegate?.cycleScrollViewDidScroll?(to: indexOnPageControl, cycleScrollView: self)
    }
}


// MARK: - WRCycleCell 相关
extension WRCycleScrollView: UICollectionViewDelegate,UICollectionViewDataSource
{
    fileprivate func setupCollectionView()
    {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.itemSize = frame.size
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout!)
        collectionView?.register(WRCycleCell.self, forCellWithReuseIdentifier: CellID)
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        addSubview(collectionView!)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return realItemCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let curItem = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! WRCycleCell
        let imgsCount:Int!
        if imgsType == .SERVER {
            imgsCount = serverImgArray?.count
            cell.serverImgPath = serverImgArray?[curItem % imgsCount]
        } else {
            imgsCount = localImgArray?.count
            cell.localImgPath = localImgArray?[curItem % imgsCount]
        }
        cell.descText = descTextArray?[curItem % imgsCount]
        
        if let _ = descTextArray
        {
            cell.descLabelFont = (descLabelFont == nil) ? cell.descLabelFont : descLabelFont!
            cell.descLabelTextColor = (descLabelTextColor == nil) ? cell.descLabelTextColor : descLabelTextColor!
            cell.descLabelHeight = (descLabelHeight == nil) ? cell.descLabelHeight : descLabelHeight!
            cell.descLabelTextAlignment = (descLabelTextAlignment == nil) ? cell.descLabelTextAlignment : descLabelTextAlignment!
            cell.bottomViewBackgroundColor = (bottomViewBackgroundColor == nil) ? cell.bottomViewBackgroundColor : bottomViewBackgroundColor!
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let indexOnPageControll = indexPath.item % imgsCount
        delegate?.cycleScrollViewDidSelect?(at: indexOnPageControll, cycleScrollView: self)
    }
}


