//
//  ServerImgController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

class ServerImgController: UIViewController
{
    var cycleScrollView:WRCycleScrollView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let height = 520 * kScreenWidth / 1080.0
        let frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: height)
        let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: serverImages)
        view.addSubview(cycleScrollView!)
        cycleScrollView?.showPageControl = false
        cycleScrollView?.delegate = self
    }
    
    // 改变 WRCycleScrollView 的大小
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // 添加描述信息
        let descs = ["韩国防部回应停止部署萨德:遵照最高统帅指导方针",
                     "勒索病毒攻击再次爆发 国内校园网大面积感染",
                     "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                     "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                     "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"]
        cycleScrollView?.descTextArray = descs
        cycleScrollView?.frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: 150)
        cycleScrollView?.showPageControl = true
    }
}

extension ServerImgController: WRCycleScrollViewDelegate
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

