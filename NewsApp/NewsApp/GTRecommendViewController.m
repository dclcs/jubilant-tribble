//
//  GTRecommendViewController.m
//  NewsApp
//
//  Created by dcl on 2021/5/5.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GTRecommendViewController

-(instancetype) init{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor lightGrayColor],[UIColor grayColor]];
    for (int i = 0; i < 5; i ++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            
            [view addSubview:({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
                view.backgroundColor = [UIColor yellowColor];
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClck)];
                tapGesture.delegate = self;
                [view addGestureRecognizer:tapGesture];
                view;
            })];
            view.backgroundColor = [colorArray objectAtIndex:i];
            view;
        })];
    }
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(void) viewClck {
    NSLog(@"viewClck");
}
@end
