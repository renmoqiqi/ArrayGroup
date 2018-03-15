//
//  WCBaseModel.m
//  WisdomCampus
//
//  Created by penghe on 2017/4/19.
//  Copyright © 2017年 WondersGroup. All rights reserved.
//

#import "WCBaseModel.h"

#define YYModelSynthCoderAndHash \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; } \
- (NSUInteger)hash { return [self yy_modelHash]; } \
- (NSString *)description { return [self yy_modelDescription]; }\
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

@implementation WCBaseModel

YYModelSynthCoderAndHash

@end
