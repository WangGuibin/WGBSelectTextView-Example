# WGBSelectTextView-Example

### 1. 解决一段文本中选中部分文本进行处理的问题 
### 2. 单击手势和长按手势区分对待
### 3. 思路: `触摸获取点坐标` -> `TextView.LayouManager计算位置` -> `前后遇到空格则截断` 这个思路是行得通的
### 4. 我爬过的坑: 自定义TextView以及UIMenuItem选中菜单,有一个致命的问题,系统的选中很不友好,取消得自己手动取消设置`selectRanage = NSMakeRanage(0,0) `,其次就是无法再响应点击事件,再系统认为,选中就是一种点击事件,即 `selectable = NO`, 则选中事件消失,空有点击而已 , `selectable = YES` 则只有选中,想过点击穿透,但是会影响选中事件.... 

**so 这个demo解决了我一块心病,故此记录一波** 

参考了这位博主的文章,特此鸣谢: [查看该博客](https://www.jianshu.com/p/e91460736064) 