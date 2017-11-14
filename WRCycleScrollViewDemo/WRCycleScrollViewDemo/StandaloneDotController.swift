//
//  StandaloneDotController.swift
//  WRCycleScrollViewDemo
//
//  Created by itwangrui on 2017/11/14.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class StandaloneDotController: UIViewController {

    var cycleScrollView:WRCycleScrollView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "网络URL"
        
        let cycleScrollViewHeightTop:CGFloat = 150
        let cycleScrollViewHeight = 520 * kScreenWidth / 1080.0
        let cycleScrollViewFrame = CGRect(x: 0, y: cycleScrollViewHeightTop, width: kScreenWidth, height: cycleScrollViewHeight)
        let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
        cycleScrollView = WRCycleScrollView(frame: cycleScrollViewFrame, type: .SERVER, imgs: serverImages, defaultDotImage: UIImage(named: "defaultDot"), currentDotImage: UIImage(named: "currentDot"))
        view.addSubview(cycleScrollView!)
        cycleScrollView?.delegate = self
        cycleScrollView?.pageControlPointSpace = 0
        
        let top = cycleScrollViewHeightTop + cycleScrollViewHeight + 16
        cycleScrollView?.outerPageControlFrame = CGRect(x: 16, y: top, width: 0, height: 0)
    }
}

extension StandaloneDotController: WRCycleScrollViewDelegate
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
