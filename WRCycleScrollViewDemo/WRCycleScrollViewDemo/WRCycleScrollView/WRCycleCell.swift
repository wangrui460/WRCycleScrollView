//
//  WRCycleCell.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit
 
class WRCycleCell: UICollectionViewCell
{
    private var imgView:UIImageView!
    var localImgPath:String? {
        didSet {
            imgView.image = UIImage(named: localImgPath!)
        }
    }
    private var webImgPath:String? {
        didSet {
            imgView.image = UIImage(named: webImgPath!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImgView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImgView()
    {
        imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        addSubview(imgView)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        imgView.frame = self.bounds
    }
}
