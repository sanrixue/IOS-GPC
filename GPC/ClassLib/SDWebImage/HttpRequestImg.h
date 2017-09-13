//
//  HttpRequestImg.h
//  shuhua
//
//  Created by Echo xue on 15/5/5.
//  Copyright (c) 2015年 shuhua. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HttpRequestImg : NSObject
+(id)upload:(NSString *)url widthParams:(NSDictionary *)params;
@end
@interface FileDetail : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSData *data;
+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data;
@end