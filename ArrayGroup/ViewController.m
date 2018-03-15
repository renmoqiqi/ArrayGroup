//
//  ViewController.m
//  ArrayGroup
//
//  Created by penghe on 2018/3/15.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "ViewController.h"
#import "WCServiceListModelV2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self sortAction];
}


//加载自定义JSON文件
- (NSArray *)loadModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CoustomObjectModel.json" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    WCServiceListModelV2 *serviceListModel = [WCServiceListModelV2 yy_modelWithDictionary:json];
    return [serviceListModel.body copy];
    
}
//自定义对象排序第利用NSSortDescriptor
- (void)sortAction
{
    NSArray *array = [self loadModel];
    NSSortDescriptor *serviceTypeDesc    = [NSSortDescriptor sortDescriptorWithKey:@"serviceType"
                                                                         ascending:YES];
    NSSortDescriptor *typeNameDesc    = [NSSortDescriptor sortDescriptorWithKey:@"type"
                                                                      ascending:NO];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:@[serviceTypeDesc,typeNameDesc]];
    
    
    [self groupAction1:[sortedArray copy]];
    
}

//对返回的数据进行区分筛选
- (NSMutableArray *)groupAction1:(NSMutableArray *)arr {
    
    NSMutableSet *set = [NSMutableSet set];
    [arr enumerateObjectsUsingBlock:^(WCServiceListModelBodyV2 * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [set addObject:model.serviceType];
    }];
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    NSArray *sortSetArray = [set sortedArrayUsingDescriptors:sortDesc];

    __block NSMutableArray *groupArr = [NSMutableArray array];
    [sortSetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serviceType = %@", obj];
        NSArray *tempArr = [NSArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];
        [groupArr addObject:tempArr];
    }];
    
    return groupArr;
}

//对返回的数据进行区分筛选
- (NSMutableArray *)groupAction2:(NSMutableArray *)arr {
    
    
    NSArray *serviceTypes = [arr valueForKeyPath:@"@distinctUnionOfObjects.serviceType"];
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES]];
    NSArray *sortSetArray = [serviceTypes sortedArrayUsingDescriptors:sortDesc];
    

    __block NSMutableArray *groupArr = [NSMutableArray array];
    [sortSetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serviceType = %@", obj];
        NSArray *tempArr = [NSArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];
        [groupArr addObject:tempArr];
    }];
    
    return groupArr;
}
@end
