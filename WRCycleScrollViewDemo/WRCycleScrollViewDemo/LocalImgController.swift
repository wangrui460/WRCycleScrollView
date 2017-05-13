//
//  ViewController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class LocalImgController: UIViewController
{
    var cycleScrollView:WRCycleScrollView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let height:CGFloat = 200
        let frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: height)
        let localImages = ["localImg6","localImg7","localImg8","localImg9","localImg10"]
        let descs = ["韩国防部回应停止部署萨德:遵照最高统帅指导方针",
                     "勒索病毒攻击再次爆发 国内校园网大面积感染",
                     "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                     "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                     "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"]
        cycleScrollView = WRCycleScrollView(frame:frame, type:.LOCAL, imgs:localImages, descs:descs)
        view.addSubview(cycleScrollView!)
    }
    
    // 改变 WRCycleScrollView 的数据
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // 把描述文字顺序换了一下
        let descs = ["勒索病毒攻击再次爆发 国内校园网大面积感染",
                     "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                     "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                     "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？",
                     "韩国防部回应停止部署萨德:遵照最高统帅指导方针"]
        cycleScrollView?.descTextArray = descs
        
        cycleScrollView?.descLabelFont = UIFont.boldSystemFont(ofSize: 15)
        cycleScrollView?.descLabelTextColor = UIColor.orange
        cycleScrollView?.descLabelHeight = 50
        cycleScrollView?.descLabelTextAlignment = NSTextAlignment.center
        cycleScrollView?.bottomViewBackgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        
        cycleScrollView?.reloadData()
    }
}

