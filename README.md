# LVPullDownMenu
###介绍：一个简单易用的下拉菜单，提供show和hide方法来管理出现和消失，提供自定义的动画时长，可选择是否开启上划退出和点击空白退出
###文件列表
* LVPulldownMenu:对window和viewcontroller的封装和整合。调用时直接调用这个类。
* LVPulldownMenuWindow:容纳viewController的window，在菜单show的时候会被创建并设置为keywindow，在菜单hide的时候会被释放。
* LVPullDownMenuViewController：在show的时候会被设置为window的rootViewController显示出来，显示时会执行动画，消失时也会执行动画，识别上划手势和点击空白处（contentView的空白处，当添加的视图没有充满contentView时有效）返回，并且这个选项可以在isReturnOpen项中设置。

###Thanks
###祝好！
