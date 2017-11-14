//
//  CustomDotController.swift
//  WRCycleScrollViewDemo
//
//  Created by itwangrui on 2017/11/14.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class CustomDotController: UIViewController
{
    var cycleScrollView:WRCycleScrollView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "网络URL"
        
        let height = 520 * kScreenWidth / 1080.0
        let frame = CGRect(x: 0, y: 150, width: kScreenWidth, height: height)
        let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: serverImages)
        cycleScrollView?.defaultPageDotImage = UIImage(named: "defaultDot")
        cycleScrollView?.currentPageDotImage = UIImage(named: "currentDot")
        view.addSubview(cycleScrollView!)
        cycleScrollView?.delegate = self
    }
}

extension CustomDotController: WRCycleScrollViewDelegate
{
    /// 点击图片事件
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动事件
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("滚动到了第\(index+1)个图片")
    }
}
