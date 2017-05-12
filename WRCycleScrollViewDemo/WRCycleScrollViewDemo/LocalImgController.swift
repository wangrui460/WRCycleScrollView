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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let height = 662 * kScreenWidth / 1080.0
        let frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: height)
        let localImages = ["localImg1","localImg2","localImg3","localImg4","localImg5"]
        let cycleScrollView = WRCycleScrollView(frame: frame, type: .LOCAL, imgs: localImages)
        view.addSubview(cycleScrollView)
    }
}

