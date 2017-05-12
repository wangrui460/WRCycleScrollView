//
//  WRCycleCell.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit
import Kingfisher
 
class WRCycleCell: UICollectionViewCell
{
    ///////////////////////////////////////////////////////
    // 对外提供的属性
    var localImgPath:String? {
        didSet {
            imgView.image = UIImage(named: localImgPath!)
        }
    }
    var serverImgPath:String? {
        didSet {
            imgView.kf.setImage(with: URL(string: serverImgPath!))
        }
    }
 
    ///////////////////////////////////////////////////////
    // 内部属性
    private var imgView:UIImageView!
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImgView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WRCycleCell  deinit")
    }
    
    func setupImgView()
    {
        imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        addSubview(imgView)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        imgView.frame = self.bounds
    }
}
