//
//  SecheduleModel.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/26.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "SecheduleModel.h"

@implementation SecheduleModel
- (instancetype)initWithDictionary:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}
@end
