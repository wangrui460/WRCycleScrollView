//
//  ViewController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

class NoPageControlController: UIViewController
{
    var cycleScrollView:WRCycleScrollView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "不显示pageControl"
        
        let height:CGFloat = 110
        let frame = CGRect(x: 0, y: 150, width: kScreenWidth, height: height)
        let localImages = ["image11","image13","image15"]
        cycleScrollView = WRCycleScrollView(frame:frame, type:.LOCAL, imgs:localImages)
        cycleScrollView!.delegate = self
        cycleScrollView?.showPageControl = false
        cycleScrollView?.imageContentModel = .scaleToFill
        view.addSubview(cycleScrollView!)
    }
}

extension NoPageControlController: WRCycleScrollViewDelegate
{
    /// 点击图片回调
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动回调
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("滚动到了第\(index+1)个图片")
    }
}

