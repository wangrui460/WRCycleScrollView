//
//  WRCycleScrollView.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

public extension WRCycleScrollView {

    /// 缓存器
    public static var imageViewCacher: (UIImageView, URL) -> Void = { (imageView, url) in
        fatalError("WRCycleScrollView.imageViewCacher must custom!")
    }
}

@objc public protocol WRCycleScrollViewDelegate
{
    /// 点击图片回调
    @objc optional func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    /// 图片滚动回调
    @objc optional func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
}

public class WRCycleScrollView: UIView, PageControlAlimentProtocol, EndlessScrollProtocol
{
    //=======================================================
    // MARK: 对外提供的属性
    //=======================================================
    public weak var delegate:WRCycleScrollViewDelegate?
    
    public var outerPageControlFrame:CGRect? {
        didSet {
            setupPageControl()
        }
    }
    
    /// 数据相关
    public var imgsType:ImgType = .SERVER
    public var localImgArray :[String]? {
        didSet {
            if let local = localImgArray {
                proxy = Proxy(type: .LOCAL, array: local)
                reloadData()
            }
        }
    }
    public var serverImgArray:[String]? {
        didSet {
            if let server = serverImgArray {
                proxy = Proxy(type: .SERVER, array: server)
                reloadData()
            }
        }
    }
    public var descTextArray :[String]?
    public var placeholderImage: UIImage?
    
    /// WRCycleCell相关
    public var imageContentModel: UIView.ContentMode?
    public var descLabelFont: UIFont?
    public var descLabelTextColor: UIColor?
    public var descLabelHeight: CGFloat?
    public var descLabelTextAlignment:NSTextAlignment?
    public var bottomViewBackgroundColor: UIColor?
    
    /// 主要功能需求相关
    override public var frame: CGRect {
        didSet {
            flowLayout?.itemSize = frame.size
            collectionView?.frame = bounds
        }
    }
    public var isAutoScroll:Bool = true {
        didSet {
            timer?.invalidate()
            timer = nil
            if isAutoScroll == true {
                setupTimer()
            }
        }
    }
    public var isEndlessScroll:Bool = true {
        didSet {
            reloadData()
        }
    }
    public var autoScrollInterval: Double = 1.5
    
    /// pageControl相关
    public var pageControlAliment: PageControlAliment = .CenterBottom
    public var defaultPageDotImage: UIImage? {
        didSet {
            setupPageControl()
        }
    }
    public var currentPageDotImage: UIImage? {
        didSet {
            setupPageControl()
        }
    }
    public var pageControlPointSpace: CGFloat = 15 {
        didSet {
            setupPageControl()
        }
    }
    public var showPageControl: Bool = true {
        didSet {
            setupPageControl()
        }
    }
    public var currentDotColor: UIColor = UIColor.orange {
        didSet {
            self.pageControl?.currentPageIndicatorTintColor = currentDotColor
        }
    }
    public var otherDotColor: UIColor = UIColor.gray {
        didSet {
            self.pageControl?.pageIndicatorTintColor = otherDotColor
        }
    }
    
    //=======================================================
    // MARK: 对外提供的方法
    //=======================================================
    public func reloadData()
    {
        timer?.invalidate()
        timer = nil
        collectionView?.reloadData()
        
        setupPageControl()
        if canChangeCycleCell == true {
            changeToFirstCycleCell(animated: false, collectionView: collectionView!)
        }
        if isAutoScroll == true {
            setupTimer()
        }
        guard let pageControl = self.pageControl else {
            return
        }
        
        if showPageControl == true {
            if let outFrame = outerPageControlFrame {
                self.relayoutPageControl(pageControl: pageControl, outerFrame: outFrame)
            } else {
                self.relayoutPageControl(pageControl: pageControl)
            }
        }
    }
    
    
    //=======================================================
    // MARK: 内部属性
    //=======================================================
    public let endlessScrollTimes:Int = 128
    fileprivate var imgsCount:Int {
        return (isEndlessScroll == true) ? (itemsInSection / endlessScrollTimes) : itemsInSection
    }
    public var itemsInSection:Int {
        guard let imgs = proxy?.imgArray else {
            return 0
        }
        return (isEndlessScroll == true) ? (imgs.count * endlessScrollTimes) : imgs.count
    }
    fileprivate var firstItem:Int {
        return (isEndlessScroll == true) ? (itemsInSection / 2) : 0
    }
    fileprivate var canChangeCycleCell:Bool {
        guard itemsInSection  != 0 ,
            let _ = collectionView,
            let _ = flowLayout else {
                return false
        }
        return true
    }
    fileprivate var indexOnPageControl:Int {
        var curIndex = Int((collectionView!.contentOffset.x + flowLayout!.itemSize.width * 0.5) / flowLayout!.itemSize.width)
        curIndex = max(0, curIndex)
        return curIndex % imgsCount
    }
    fileprivate var proxy:Proxy!
    fileprivate var flowLayout:UICollectionViewFlowLayout?
    public var collectionView:UICollectionView?
    fileprivate let CellID = "WRCycleCell"
    fileprivate var pageControl:WRPageControl?
    public var timer:Timer?
    // 标识子控件是否布局完成，布局完成后在layoutSubviews方法中就不执行 changeToFirstCycleCell 方法
    fileprivate var isLoadOver = false
    
    
    //=======================================================
    // MARK: 构造方法
    //=======================================================
    /// 构造方法
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - type:  ImagesType                         default:Server
    ///   - imgs:  localImgArray / serverImgArray     default:nil
    ///   - descs: descTextArray                      default:nil
    public init(frame: CGRect, type:ImgType = .SERVER, imgs:[String]? = nil, descs:[String]? = nil, defaultDotImage:UIImage? = nil, currentDotImage:UIImage? = nil, placeholderImage:UIImage? = nil)
    {
        super.init(frame: frame)
        setupCollectionView()
        defaultPageDotImage = defaultDotImage
        currentPageDotImage = currentDotImage
        self.placeholderImage = placeholderImage
        imgsType = type
        if imgsType == .SERVER {
            if let server = imgs {
                proxy = Proxy(type: .SERVER, array: server)
            }
        }
        else {
            if let local = imgs {
                proxy = Proxy(type: .LOCAL, array: local)
            }
        }
        
        if let descTexts = descs {
            descTextArray = descTexts
        }
        reloadData()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // 支持StoryBoard创建
        super.init(coder: aDecoder)
        self.setupCollectionView()
    }
    
    deinit {
        collectionView?.delegate = nil
        print("WRCycleScrollView  deinit")
    }
    
    //=======================================================
    // MARK: 内部方法（layoutSubviews、willMove）
    //=======================================================
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        // 解决WRCycleCell自动偏移问题
        collectionView?.contentInset = .zero
        if isLoadOver == false && canChangeCycleCell == true {
            changeToFirstCycleCell(animated: false, collectionView: collectionView!)
        }
        
        guard let pageControl = self.pageControl else {
            return
        }
        
        if showPageControl == true {
            if let outFrame = outerPageControlFrame {
                self.relayoutPageControl(pageControl: pageControl, outerFrame: outFrame)
            } else {
                self.relayoutPageControl(pageControl: pageControl)
            }
        }
    }
    
    override public func willMove(toSuperview newSuperview: UIView?)
    {   // 解决定时器导致的循环引用
        super.willMove(toSuperview: newSuperview)
        // 展现的时候newSuper不为nil，离开的时候newSuper为nil
        guard let _ = newSuperview else {
            timer?.invalidate()
            timer = nil
            return
        }
    }
}

//=======================================================
// MARK: - 定时器、自动滚动、scrollView代理方法
//=======================================================
public extension WRCycleScrollView
{
    func setupTimer()
    {
        timer = Timer(timeInterval: autoScrollInterval, target: self, selector: #selector(autoChangeCycleCell), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func autoChangeCycleCell()
    {
        if canChangeCycleCell == true {
            changeCycleCell(collectionView: collectionView!)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if isAutoScroll == true {
            setupTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        guard canChangeCycleCell else {
            return
        }
        delegate?.cycleScrollViewDidScroll?(to: indexOnPageControl, cycleScrollView: self)
        
        if indexOnPageControl >= firstItem {
            isLoadOver = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        guard canChangeCycleCell else {
            return
        }
        pageControl?.currentPage = indexOnPageControl
    }
}

//=======================================================
// MARK: - pageControl页面
//=======================================================
public extension WRCycleScrollView
{
    fileprivate func setupPageControl()
    {
        pageControl?.removeFromSuperview()
        if showPageControl == true
        {
            pageControl = WRPageControl(frame: CGRect.zero, currentImage: currentPageDotImage, defaultImage: defaultPageDotImage)
            pageControl?.numberOfPages = imgsCount
            pageControl?.hidesForSinglePage = true
            pageControl?.currentPageIndicatorTintColor = self.currentDotColor
            pageControl?.pageIndicatorTintColor = self.otherDotColor
            pageControl?.isUserInteractionEnabled = false
            pageControl?.pointSpace = pageControlPointSpace
            
            if let _ = outerPageControlFrame {
                superview?.addSubview(pageControl!)
            } else {
                addSubview(pageControl!)
            }
        }
    }
}

//=======================================================
// MARK: - WRCycleCell 相关
//=======================================================
extension WRCycleScrollView: UICollectionViewDelegate,UICollectionViewDataSource
{
    fileprivate func setupCollectionView()
    {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.itemSize = frame.size
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout!)
        collectionView?.register(WRCycleCell.self, forCellWithReuseIdentifier: CellID)
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        addSubview(collectionView!)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return itemsInSection
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let curIndex = indexPath.item % imgsCount
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! WRCycleCell
        cell.placeholderImage = placeholderImage
        cell.imgSource = proxy[curIndex]
        cell.descText = descTextArray?[curIndex]
        
        if let _ = descTextArray
        {
            cell.imageContentModel = (imageContentModel == nil) ? cell.imageContentModel : imageContentModel!
            cell.descLabelFont = (descLabelFont == nil) ? cell.descLabelFont : descLabelFont!
            cell.descLabelTextColor = (descLabelTextColor == nil) ? cell.descLabelTextColor : descLabelTextColor!
            cell.descLabelHeight = (descLabelHeight == nil) ? cell.descLabelHeight : descLabelHeight!
            cell.descLabelTextAlignment = (descLabelTextAlignment == nil) ? cell.descLabelTextAlignment : descLabelTextAlignment!
            cell.bottomViewBackgroundColor = (bottomViewBackgroundColor == nil) ? cell.bottomViewBackgroundColor : bottomViewBackgroundColor!
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        delegate?.cycleScrollViewDidSelect?(at: indexOnPageControl, cycleScrollView: self)
    }
}


