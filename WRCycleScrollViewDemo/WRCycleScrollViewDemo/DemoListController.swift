//
//  DemoListController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

class DemoListController: UIViewController
{
    lazy var tableView:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        title = "WRCycleScrollView"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - tableView delegate / dataSource
extension DemoListController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        var str:String? = nil
        switch indexPath.row {
        case 0:
            str = "本地图片"
        case 1:
            str = "网络URL"
        case 2:
            str = "支持StoryBoard创建"
        case 3:
            str = "不无限轮播"
        case 4:
            str = "不显示pageControl"
        case 5:
            str = "知乎日报效果"
        case 6:
            str = "自定义dot"
        case 7:
            str = "独立出dot"
        default:
            str = ""
        }
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(LocalImgController(), animated: true)
        case 1:
            navigationController?.pushViewController(ServerImgController(), animated: true)
        case 2:
            
            let SBVC:SBController = UIStoryboard.init(name: "StoryBoardController", bundle: nil).instantiateInitialViewController() as! SBController
            navigationController?.pushViewController(SBVC, animated: true)
        case 3:
            navigationController?.pushViewController(NoEndlessController(), animated: true)
        case 4:
            navigationController?.pushViewController(NoPageControlController(), animated: true)
        case 5:
            navigationController?.pushViewController(ZhiHuController(), animated: true)
        case 6:
            navigationController?.pushViewController(CustomDotController(), animated: true)
        case 7:
            navigationController?.pushViewController(StandaloneDotController(), animated: true)
        default:
           break
        }
    }
}




