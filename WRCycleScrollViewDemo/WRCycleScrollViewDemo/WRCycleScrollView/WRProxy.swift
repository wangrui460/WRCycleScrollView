//
//  WRProxy.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/15.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

/////////////////////////////////////////////////////////////////////////////
// MARK: 数据 相关
/////////////////////////////////////////////////////////////////////////////

// 图片资源
enum ImgSource {
    case SERVER(url:URL)
    case LOCAL(name:String)
}

// 图片类型
enum ImgType:Int {
    case SERVER = 0     // default
    case LOCAL = 1
}

struct Proxy
{
    var imgType:ImgType = .SERVER
    var imgArray:[ImgSource] = [ImgSource]()
    
    // 下标法获取imgArray中对应索引的ImgSource eg: proxy[0] == imgArray[0]
    subscript (index:Int) -> ImgSource {
        get {
            return imgArray[index]
        }
    }
    
    // 构造方法
    init(type:ImgType, array:[String])
    {
        imgType = type
        if imgType == .SERVER
        {
            imgArray = array.map({ (urlStr) -> ImgSource in
                return ImgSource.SERVER(url: URL(string: urlStr)!)
            })
        }
        else
        {
            imgArray = array.map({ (name) -> ImgSource in
                return ImgSource.LOCAL(name: name)
            })
        }
    }
}


/////////////////////////////////////////////////////////////////////////////
// MARK: pageControl 相关
/////////////////////////////////////////////////////////////////////////////

private let WRPageControlMargin: CGFloat = 15
private let WRPageControlPointWidth: CGFloat = 2

enum PageControlAliment {
    case CenterBottom
    case RightBottom
    case LeftBottom
}

protocol PageControlAlimentProtocol
{
    // Property in protocol must have explicit { get } or { get set } specifier
    var pageControlAliment: PageControlAliment { get set }
    var pageControlPointSpace: CGFloat { get set }
    func relayoutPageControl(pageControl: WRPageControl)
    func relayoutPageControl(pageControl: WRPageControl, outerFrame:CGRect)
}

extension PageControlAlimentProtocol where Self : UIView
{   // TODO: 等待优化
    func relayoutPageControl(pageControl: WRPageControl)
    {
        if pageControl.isHidden == false
        {
            let pageH:CGFloat = 20//pageControl.pageSize.height
            let pageY = bounds.height - pageH
            let pageW = pageControl.pageSize.width
            var pageX:CGFloat = 0
            
            switch self.pageControlAliment {
            case .CenterBottom:
                pageX = CGFloat(self.bounds.width / 2) - pageW * 0.5
            case .RightBottom:
                pageX = bounds.width - pageW - WRPageControlMargin
            case .LeftBottom:
                pageX = bounds.origin.x + WRPageControlMargin
            }
            pageControl.frame = CGRect(x:pageX, y:pageY, width:pageW, height:pageH)
        }
    }
    func relayoutPageControl(pageControl: WRPageControl, outerFrame:CGRect)
    {
        if pageControl.isHidden == false {
            pageControl.frame = CGRect(x:outerFrame.origin.x, y:outerFrame.origin.y, width:pageControl.pageSize.width, height:pageControl.pageSize.height)
        }
    }
}


/////////////////////////////////////////////////////////////////////////////
// MARK: 无限轮播 相关
/////////////////////////////////////////////////////////////////////////////

protocol EndlessScrollProtocol
{
    /////////////////////////////////
    /// 是否自动滚动
    var isAutoScroll: Bool { get set }
    /// 自动滚动的时间间隔
    var autoScrollInterval: Double { get set }
    /// 用于自动滚动的定时器
    var timer:Timer? { get set }
    
    /////////////////////////////////
    /// 是否无限轮播
    var isEndlessScroll: Bool { get set }
    /// 无线轮播中，一组图片最多轮播多少次
    var endlessScrollTimes: Int { get }
    /// 真实的cell数量
    var itemsInSection: Int { get }
    
    /** 设置定时器，用于自动滚动 */
    func setupTimer()
    
    /** 滚动到第一个cell (在无限轮播中就是中间的那个cell) */
    func changeToFirstCycleCell(animated: Bool, collectionView: UICollectionView)
}

extension EndlessScrollProtocol where Self : UIView
{
    func changeCycleCell(collectionView: UICollectionView)
    {
        guard itemsInSection != 0 else {
            return
        }
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let curItem = Int(collectionView.contentOffset.x / flowLayout.itemSize.width)
        if curItem == itemsInSection - 1
        {
            let animated = (isEndlessScroll == true) ? false : true
            changeToFirstCycleCell(animated: animated, collectionView: collectionView)
        }
        else
        {
            let indexPath = IndexPath(item: curItem + 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: true)
        }
    }
    
    func changeToFirstCycleCell(animated: Bool, collectionView: UICollectionView)
    {
        guard itemsInSection != 0 else {
            return
        }
        
        let firstItem = (isEndlessScroll == true) ? (itemsInSection / 2) : 0
        let indexPath = IndexPath(item: firstItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: animated)
    }
}






















