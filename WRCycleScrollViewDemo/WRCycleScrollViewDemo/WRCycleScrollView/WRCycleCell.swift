//
//  WRCycleCell.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

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
    var descText:String? {
        didSet {
            descLabel.isHidden  = (descText == nil) ? true : false
            bottomView.isHidden = (descText == nil) ? true : false
            descLabel.text = descText
        }
    }
    
    override var frame: CGRect {
        didSet {
            bounds.size = frame.size
        }
    }
    
    var descLabelFont: UIFont = UIFont(name: "Helvetica-Bold", size: 18)! {
        didSet {
            descLabel.font = descLabelFont
        }
    }
    var descLabelTextColor: UIColor = UIColor.white {
        didSet {
            descLabel.textColor = descLabelTextColor
        }
    }
    var descLabelHeight: CGFloat = 60 {
        didSet {
            descLabel.frame.size.height = descLabelHeight
        }
    }
    var descLabelTextAlignment:NSTextAlignment = .left {
        didSet {
            descLabel.textAlignment = descLabelTextAlignment
        }
    }
    
    var bottomViewBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.5) {
        didSet {
            bottomView.backgroundColor = bottomViewBackgroundColor
        }
    }
 
    ///////////////////////////////////////////////////////
    /// 内部属性
    private var imgView:UIImageView!
    private var descLabel:UILabel!
    private var bottomView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupImgView()
        setupDescLabel()
        setupBottomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WRCycleCell  deinit")
    }
    
    private func setupImgView()
    {
        imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        addSubview(imgView)
    }
    
    private func setupDescLabel()
    {
        descLabel = UILabel()
        descLabel.text = descText
        descLabel.numberOfLines = 0
        descLabel.font = descLabelFont
        descLabel.textColor = descLabelTextColor
        descLabel.frame.size.height = descLabelHeight
        descLabel.textAlignment = descLabelTextAlignment
        addSubview(descLabel)
        descLabel.isHidden = true
    }
    
    private func setupBottomView()
    {
        bottomView = UIView()
        bottomView.backgroundColor = bottomViewBackgroundColor
        addSubview(bottomView)
        bottomView.isHidden = true
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        imgView.frame = self.bounds
        
        if let _ = descText
        {
            let margin:CGFloat = 16
            let labelWidth     = imgView.bounds.width - 2 * margin
            let labelHeight    = descLabelHeight
            let labelY         = bounds.height - labelHeight
            descLabel.frame    = CGRect(x: margin, y: labelY, width: labelWidth, height: labelHeight)
            bottomView.frame   = CGRect(x: 0, y: labelY, width: imgView.bounds.width, height: labelHeight)
            bringSubview(toFront: descLabel)
        }
    }
}



