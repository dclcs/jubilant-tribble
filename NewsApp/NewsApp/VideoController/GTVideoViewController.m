//
//  GTVideoViewController.m
//  NewsApp
//
//  Created by dcl on 2021/5/3.
//

#import "GTVideoViewController.h"
#import "GTVideoCoverView.h"
#import "GTVideoToolBar.h"
@interface GTVideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation GTVideoViewController

-(instancetype) init {
    self = [super init];
    if(self){
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.width / 16 * 9 + GTVideoToolBarHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[GTVideoCoverView class] forCellWithReuseIdentifier:@"GTVideoCoverView"];
    
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    GTVideoCoverView *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVideoCoverView" forIndexPath:indexPath];
    if ([cell isKindOfClass:[GTVideoCoverView class]]) {
        //http://192.168.2.114/m1.mp4
        [(GTVideoCoverView *)cell layoutWithVideoCoverUrl:@"icon.bundle/gv_cover.png" videoUrl:@"http://192.168.2.114/m1.mp4"];
    }
    return cell;
}


@end
