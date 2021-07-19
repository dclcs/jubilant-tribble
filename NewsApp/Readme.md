# News App

### UIWindow

- 特殊的UIView，提供APP中展示内容的基础窗口

- MVC

  - Model 数据
  - View 视图 - UIView
    - 将Model中的数据进行展示
  - Controller 管理 - UIController 
    - 处理逻辑功能

- 用Xcode新建一个IOS 的 APP

  - 其结构目录如下：

    <img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gpntm57mppj30e60k2taq.jpg" alt="截屏2021-04-18 下午1.13.26" style="zoom: 50%;" />

    

- UIView

  - 布局 和 管理 子View

    - 使用栈管理全部的子View

    <img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gpntod0bmwj30hs0vk3yt.jpg" alt="simulator_screenshot_B75F53D2-EE91-4F55-8BB6-E5195C58AFB7" style="zoom:50%;" /><img src="../../../Library/Application%20Support/typora-user-images/simulator_screenshot_621AD30B-8283-4718-9214-FA7036997064.png" alt="simulator_screenshot_621AD30B-8283-4718-9214-FA7036997064" style="zoom:50%;" />

    上面两个的代码如下：

    ```objective-c
    //左边
        UIView *view2 = [[UIView alloc] init];
        view2.backgroundColor = [UIColor greenColor];
        view2.frame = CGRectMake(150, 150, 100, 100);
        [self.view addSubview:view2];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(100, 110, 100, 100);
        [self.view addSubview:view];
    //右边
    		UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(100, 110, 100, 100);
        [self.view addSubview:view];
        
        UIView *view2 = [[UIView alloc] init];
        view2.backgroundColor = [UIColor greenColor];
        view2.frame = CGRectMake(150, 150, 100, 100);
        [self.view addSubview:view2];
    ```

    可以发现先入栈的在后面。

  - UIView的启动流程

    - willMoveToSuperview -> didMoveToSuperview->willMoveToWindow->didMoveToWindow->显示在屏幕上

- UIViewController
  - 自身包含View 可以理解成一个容器
    - 管理View视图的生命周期、响应用户操作、和App整体交互，视图切换；作为一个Container管理多个Controller和动画
  - 生命周期：
    - init -> viewDidLoad -> viewWillAppear -> viewDidAppear -> viewWillDisappear -> viewDidDisappear -> Dealloc

- UITabBarController

  - 管理多个ViewController切换

  - 通过底部对应按钮，选中对应需要展示的ViewController

  - UITabBar

    ```objective-c
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    UIViewController *controller1 = [[UIViewController alloc] init];
    controller1.view.backgroundColor = [UIColor redColor];
    controller1.tabBarItem.title = @"新闻";
    controller1.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
    controller1.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor yellowColor];
    controller2.tabBarItem.title = @"视频";
    controller2.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
    controller2.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    
    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = [UIColor greenColor];
    controller3.tabBarItem.title = @"推荐";
    controller3.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
    controller3.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    
    UIViewController *controller4 = [[UIViewController alloc] init];
    controller4.view.backgroundColor = [UIColor lightGrayColor];
    controller4.tabBarItem.title = @"我的";
    controller4.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
    controller4.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];
    
    [tabbarController setViewControllers:@[controller1, controller2, controller3, controller4]];
    ```

    <img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gpnvkbzersj30hs0vkgmv.jpg" alt="simulator_screenshot_E75CC4D5-75FD-4623-B26E-E7E7591C53D6" style="zoom: 33%;" /><img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gpnvlw4xekj30hs0vkt9m.jpg" alt="simulator_screenshot_9B1AEF24-1298-4B64-89BF-53A802FCC1B7" style="zoom: 33%;" /><img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gpnvn0ffvij30hs0vk75h.jpg" alt="simulator_screenshot_61A32F95-43C5-437E-8697-EC4B9845C7BE" style="zoom:33%;" /><img src="https://tva1.sinaimg.cn/large/008eGmZEgy1gpnvktrexfj30hs0vkjsn.jpg" alt="simulator_screenshot_6E317D8E-2E41-477B-8EC6-3020F6EB07BE" style="zoom: 33%;" />

  ### UINavigationController

  - 通过UINavigationBar 响应操作，处理UIViewController的切换

  - 目标：将新闻页面变为Navigation

    ```objective-c
    ViewController *viewController = [[ViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
    //    UIViewController *controller1 = [[UIViewController alloc] init];
        navigationController.view.backgroundColor = [UIColor whiteColor];
        navigationController.tabBarItem.title = @"新闻";
        navigationController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        navigationController.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    ```

  - 为图中方块加上响应事件

    ```objective-c
    -(void) viewDidLoad {
      ...
      UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushController)];
      [view addGestureRecognizer:tapGesture];
      ...
    }
    
    -(void)pushController{
        
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        viewController.navigationItem.title = @"内容"; //设置标题和右侧标题
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    ```

    <img src="https://tva1.sinaimg.cn/large/008i3skNgy1gpw68ynlefj30hs0vk766.jpg" alt="simulator_screenshot_90270642-1CD5-4B13-96ED-F1532E7F3DE7" style="zoom:50%;" /><img src="../../../Library/Application%20Support/typora-user-images/simulator_screenshot_8A4B1BB0-484C-468C-B103-37B85CA304F0.png" alt="simulator_screenshot_8A4B1BB0-484C-468C-B103-37B85CA304F0" style="zoom:50%;" />

    

### Deletgate

### UITableView

- tableHeaderView，tableFooterView， UITableView->UITableViewCell



### UICollectionView

- UICollectionViewCell
  - 不提供默认的样式
  - 不以行为设计基础
- 基于 datasource 和 delegate 驱动的




### UIScrollView

### UILabel

### UIImage

