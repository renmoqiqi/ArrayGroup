//
//Created by ESJsonFormatForMac on 18/03/08.
//

#import "WCBaseModel.h"

@class WCServiceListModelBodyV2;
@interface WCServiceListModelV2 : WCBaseModel

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray<WCServiceListModelBodyV2 *> *body;

@property (nonatomic, assign) NSInteger code;

@end

@interface WCServiceListModelBodyV2 : WCBaseModel

@property (nonatomic, copy) NSString *phoneUrl;

@property (nonatomic, assign) NSInteger countNum;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *iconNewurl;

@property (nonatomic, copy) NSString *serviceType;

@property (nonatomic, copy) NSString *englishName;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;

@end

