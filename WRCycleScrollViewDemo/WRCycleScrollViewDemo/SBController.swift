//
//  SBController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/6/21.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class SBController: UIViewController
{

    @IBOutlet weak var cycleScrollView: WRCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "StoryBoard创建"
        
        let localImages = ["localImg6","localImg7","localImg8","localImg9","localImg10"]
        let descs = ["韩国防部回应停止部署萨德:遵照最高统帅指导方针",
                     " 勒索病毒攻击再次爆发  国内校园网大面积感染，Mac什么事都没有",
                     "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                     "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                     "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"]

        cycleScrollView.delegate = self
        view.addSubview(cycleScrollView)
        cycleScrollView.localImgArray = localImages
        cycleScrollView.descTextArray = descs
        cycleScrollView.descLabelHeight = 40
        cycleScrollView.descLabelFont = UIFont.systemFont(ofSize: 13)
        cycleScrollView.pageControlAliment = .RightBottom
    }
}


extension SBController: WRCycleScrollViewDelegate
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
