//
//  SceneDelegate.m
//  NewsApp
//
//  Created by dcl on 2021/4/18.
//

#import "SceneDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommendViewController.h"
#import "GTSplashView.h"
@interface SceneDelegate ()<UITabBarControllerDelegate>

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
	UIWindowScene *windowScene = (UIWindowScene *)scene;
	self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
	self.window.frame = windowScene.coordinateSpace.bounds;
	UITabBarController *tabbarController = [[UITabBarController alloc] init];
	// 新闻页面
	GTNewsViewController *viewController = [[GTNewsViewController alloc] init];


	//视频页面
	GTVideoViewController *videoController = [[GTVideoViewController alloc] init];
//    videoController.view.backgroundColor = [UIColor yellowColor];

	//推荐页面
	GTRecommendViewController *recommendController = [[GTRecommendViewController alloc] init];


	UIViewController *mineViewController = [[UIViewController alloc] init];
	mineViewController.view.backgroundColor = [UIColor lightGrayColor];
	mineViewController.tabBarItem.title = @"我的";
	mineViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
	mineViewController.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];

	[tabbarController setViewControllers:@[viewController, videoController, recommendController, mineViewController]];

	tabbarController.delegate = self;

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];

	self.window.rootViewController = navigationController;
	[self.window makeKeyAndVisible];
    
    [self.window addSubview:({
        GTSplashView *splashView  = [[GTSplashView alloc] initWithFrame:self.window.frame];
        splashView;
    })];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    NSLog(@"did select;");
}

- (void)sceneDidDisconnect:(UIScene *)scene {
	// Called as the scene is being released by the system.
	// This occurs shortly after the scene enters the background, or when its session is discarded.
	// Release any resources associated with this scene that can be re-created the next time the scene connects.
	// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
	// Called when the scene has moved from an inactive state to an active state.
	// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
	// Called when the scene will move from an active state to an inactive state.
	// This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
	// Called as the scene transitions from the background to the foreground.
	// Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
	// Called as the scene transitions from the foreground to the background.
	// Use this method to save data, release shared resources, and store enough scene-specific state information
	// to restore the scene back to its current state.
}


@end
