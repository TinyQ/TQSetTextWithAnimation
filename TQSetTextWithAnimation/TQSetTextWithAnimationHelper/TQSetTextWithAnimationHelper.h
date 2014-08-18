//
//  TQSetTextWithAnimationHelper.h
//  TQSetTextWithAnimation
//
//  Created by qfu on 8/18/14.
//  Copyright (c) 2014 tinyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQSetTextWithAnimationHelper : NSObject

- (instancetype)initWithTarget:(id)tatget;


- (void)setTextWithString:(NSString *)string;


- (void)setTextWithAttString:(NSAttributedString *)attString;

@end
