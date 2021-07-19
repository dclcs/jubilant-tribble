//
//  GTListLoader.m
//  NewsApp
//
//  Created by dcl on 2021/5/15.
//

#import "GTListLoader.h"
#import <AFNetworking.h>
#import "GTListItem.h"
@implementation GTListLoader

-(void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {
    NSArray <GTListItem *> *listdata = [self _readDataFromLocal];
    if (listdata) {
        finishBlock(YES, listdata);
    }
    
	NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
	NSURL *listURL = [NSURL URLWithString:urlString];
	NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
	NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
	                                          NSError *jsonError;
	                                          id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型检查
	                                          NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
	                                          NSMutableArray *listItemArray = @[].mutableCopy;
	                                          for (NSDictionary *info in dataArray  ) {
							  GTListItem *listItem = [[GTListItem alloc] init];
							  [listItem configWithDictionary:info];
							  [listItemArray addObject:listItem];
						  }
        
        [weakSelf _archiveListDataWithArray:listItemArray.copy];
	                                          dispatch_async(dispatch_get_main_queue(), ^{
									 if (finishBlock) {
										 finishBlock(error == nil, listItemArray.copy);
									 }
								 });
					  }];
	[dataTask resume];
}

#pragma mark - private method
-(NSArray<GTListItem*>*) _readDataFromLocal{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath =  [cachePath stringByAppendingPathComponent:@"GTData/list"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<GTListItem*>*)unarchiveObj;
    }
    return nil;
}

-(void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cachePath = [pathArray firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    
    NSString *listDataPath =  [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    

//    [[NSUserDefaults standardUserDefaults] setObject:listData forKey:@"listData"];
//    NSData *test = [[NSUserDefaults standardUserDefaults] dataForKey:@"listData"];
//    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:test error:nil];
    NSLog(@"");
}
@end
