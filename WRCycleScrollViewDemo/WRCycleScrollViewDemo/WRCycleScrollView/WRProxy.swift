//
//  WRProxy.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/15.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

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
    func replacePageControl(pageControl: UIPageControl)
}

extension PageControlAlimentProtocol where Self : UIView
{
    func replacePageControl(pageControl: UIPageControl)
    {
        if pageControl.isHidden == false
        {
            let pageH:CGFloat = 20
            let pageY = bounds.height -  pageH
            let pageW = CGFloat(pageControl.numberOfPages - 1) * (self.pageControlPointSpace + WRPageControlPointWidth) + WRPageControlPointWidth
            var pageX:CGFloat = 0
            
            switch self.pageControlAliment {
            case .CenterBottom:
                pageX = CGFloat(center.x) - pageW * 0.5
            case .RightBottom:
                pageX = bounds.width - pageW - WRPageControlMargin
            case .LeftBottom:
                pageX = bounds.origin.x + WRPageControlMargin
            }
            pageControl.frame = CGRect(x:pageX, y:pageY, width:pageW, height:pageH)
        }
    }
}




























