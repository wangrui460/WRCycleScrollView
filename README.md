![image](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/WRCycleScrollView.png)

#####[强烈推荐使用：WRNavigationBar  超简单！！！ 一行代码设置状态栏、导航栏按钮、标题、颜色、透明度，移动等](https://github.com/wangrui460/WRNavigationBar)
------------------------------------------------------------

## Requirements
- iOS 8+
- Xcode 8+


## Demo 
---
demo列表

![demo列表](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/demos.png)

---
知乎日报

![知乎日报](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/知乎日报.gif)

---
本地图片轮播

![本地图片轮播](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/本地图片轮播.gif)

---
网络图片轮播

![网络图片轮播](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/网络图片轮播.gif)

---
StoryBoard创建

![StoryBoard创建](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/StoryBoard创建.gif)

---
不无限轮播

![不无限轮播](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/不无限轮播.gif)

---
不显示pageControl

![不显示pageControl](https://github.com/wangrui460/WRCycleScrollView/raw/master/screenshots/不显示pageControl.gif)


## Installation 

> **手动拖入**
> 将 WRCycleScrollView 文件夹拽入项目中即可使用

## How To Use

<pre><code>
var cycleScrollView:WRCycleScrollView?
let height = 520 * kScreenWidth / 1080.0
let frame = CGRect(x: 0, y: 150, width: kScreenWidth, height: height)
// 可加载网络图片或者本地图片
let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",              "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",                  "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
// 构造方法
cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: serverImages)
view.addSubview(cycleScrollView!)
// 添加代理
cycleScrollView?.delegate = self
</code></pre>

代理方法
<pre><code>
extension ServerImgController: WRCycleScrollViewDelegate
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
</code></pre>


# Contact me
- Weibo: [@wangrui460](http://weibo.com/u/5145779726?is_all=1)
- Email:  wangruidev@gmail.com
- QQ：1204607318

# License

WRCycleScrollView is available under the MIT license. See the LICENSE file for more info.

