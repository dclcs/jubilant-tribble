//
//  GTDetailViewController.m
//  NewsApp
//
//  Created by dcl on 2021/5/8.
//

#import "GTDetailViewController.h"
#import "GTScreen.h"
#import <WebKit/WebKit.h>
@interface GTDetailViewController ()<WKNavigationDelegate>
@property(nonatomic, strong, readwrite) WKWebView *webView;
@property(nonatomic, strong, readwrite) UIProgressView *processView;
@property(nonatomic, copy, readwrite) NSString *articleUrl;
@end

@implementation GTDetailViewController

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
-(instancetype)initWithUrlString:(NSString *)urlString{
    self = [super init];
    if(self){
        self.articleUrl = urlString;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, self.view.frame.size.height - STATUSBARHEIGHT - 44)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];
    
    [self.view addSubview:({
        self.processView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, 20)];
        self.processView;
    })];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.processView.progress = self.webView.estimatedProgress;
}


@end
