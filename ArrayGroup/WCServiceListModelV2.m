//
//Created by ESJsonFormatForMac on 18/03/08.
//

#import "WCServiceListModelV2.h"
@implementation WCServiceListModelV2

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"body" : [WCServiceListModelBodyV2 class]};
}


@end

@implementation WCServiceListModelBodyV2

//其实是不相等的因为serviceType 被认为改变了 如果不认为改变这个方法就是判断两个对象是否相等
- (BOOL)isEqualToServiceListModelBodyV2:(WCServiceListModelBodyV2 *)serviceListModelBodyV2 {
    if (!serviceListModelBodyV2) {
        return NO;
    }
    
    BOOL havePhoneUrls = (!self.phoneUrl && !serviceListModelBodyV2.phoneUrl) || [self.phoneUrl isEqualToString:serviceListModelBodyV2.phoneUrl];
    BOOL haveCountNum = (!self.countNum && !serviceListModelBodyV2.countNum) || (self.countNum == serviceListModelBodyV2.countNum);
    BOOL haveIconUrl = (!self.iconUrl && !serviceListModelBodyV2.iconUrl) || [self.iconUrl isEqualToString:serviceListModelBodyV2.iconUrl];
    BOOL haveCode = (!self.code && !serviceListModelBodyV2.code) || [self.code isEqualToString:serviceListModelBodyV2.code];
    BOOL haveIconNewurl = (!self.iconNewurl && !serviceListModelBodyV2.iconNewurl) || [self.iconNewurl isEqualToString:serviceListModelBodyV2.iconNewurl];
//    BOOL haveServiceType = (!self.serviceType && !serviceListModelBodyV2.serviceType) || [self.serviceType isEqualToString:serviceListModelBodyV2.serviceType];
    BOOL haveEnglishName = (!self.englishName && !serviceListModelBodyV2.englishName) || [self.englishName isEqualToString:serviceListModelBodyV2.englishName];
    BOOL haveName = (!self.name && !serviceListModelBodyV2.name) || [self.name isEqualToString:serviceListModelBodyV2.name];
    BOOL haveDesc = (!self.desc && !serviceListModelBodyV2.desc) || [self.desc isEqualToString:serviceListModelBodyV2.desc];
    BOOL haveType = (!self.type && !serviceListModelBodyV2.type) || (self.type == serviceListModelBodyV2.type);

    
    return havePhoneUrls && haveCountNum && haveIconUrl && haveCode && haveIconNewurl  && haveEnglishName && haveName && haveDesc && haveType;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[WCServiceListModelBodyV2 class]]) {
        return NO;
    }
    
    return [self isEqualToServiceListModelBodyV2:(WCServiceListModelBodyV2 *)object];
}

- (NSUInteger)hash {
    return [self.phoneUrl hash] ^ self.countNum ^ [self.code hash] ^ [self.iconNewurl hash]  ^ [self.englishName hash] ^ [self.name hash] ^ [self.desc hash] ^ self.type;
}

- (NSComparisonResult)compare:(WCServiceListModelBodyV2 *)otherObject {
    
    //默认按serviceType排序
    NSComparisonResult result = [self.serviceType compare:otherObject.serviceType];
    //注意:基本数据类型要进行数据转换
    //如果serviceType一样，就按照type排序
    if (result == NSOrderedSame) {
        result = [[NSNumber numberWithInteger:self.type] compare:[NSNumber numberWithInteger:otherObject.type]];
        if (result == NSOrderedAscending) {
            return NSOrderedDescending;
        }
    }
    return result;
}

@end


