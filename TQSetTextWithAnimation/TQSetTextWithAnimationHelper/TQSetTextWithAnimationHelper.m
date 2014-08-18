//
//  TQSetTextWithAnimationHelper.m
//  TQSetTextWithAnimation
//
//  Created by qfu on 8/18/14.
//  Copyright (c) 2014 tinyq. All rights reserved.
//

#import "TQSetTextWithAnimationHelper.h"

#define kInterval 0.02

@interface TQSetTextWithAnimationHelper()

@property (nonatomic,weak) id targetObject;

@property (nonatomic,strong) NSOperationQueue* textSetOperationQueue;

@property (nonatomic,copy) NSString *tempString;

@end

@implementation TQSetTextWithAnimationHelper

- (instancetype)initWithTarget:(id)tatget
{
    self = [super init];
    if (self) {
        _targetObject = tatget;
        _tempString   = @"";
        _textSetOperationQueue = [[NSOperationQueue alloc] init];
        _textSetOperationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)setTextWithString:(NSString *)string
{
    NSInteger index = 0;
    
    if (self.tempString && string.length > 0 && [string hasPrefix:self.tempString])
    {
        index = self.tempString.length;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = index; i<string.length; i++)
    {
        NSString * item =[string substringWithRange:NSMakeRange(0, i+1)];
        
        [array addObject:item];
    }
    
    [self setTextWithArray:array];
    
    self.tempString = string;
}

- (void)setTextWithAttString:(NSAttributedString *)attString
{
    if (attString == nil){
        return;
    }
    
    NSString *attstr = [attString string];
    
    NSInteger index = 0;
    
    if (self.tempString && attString.length > 0 && [attstr hasPrefix:self.tempString])
    {
        index = self.tempString.length;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = index; i<attString.length; i++)
    {
        NSAttributedString *item = [attString attributedSubstringFromRange:NSMakeRange(0, i+1)];
        
        [array addObject:item];
    }
    
    [self setTextWithArray:array];
    
    self.tempString = attString.string;
}

- (void)setTextWithArray:(NSArray *)array
{
    for (int i = 0; i < array.count; i++)
    {
        [self.textSetOperationQueue addOperationWithBlock:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                id text = array[i];
                
                if ([text isKindOfClass:[NSString class]])
                {
                    [self setTextToTargetWithString:text];
                }
                else if([text isKindOfClass:[NSAttributedString class]])
                {
                    [self setTextToTargetWithAttString:text];
                }
            });
            
            usleep(1 * 1000 * 1000 * kInterval);
        }];
    }
}

- (void)setTextToTargetWithString:(NSString *)text
{
    if ([self.targetObject isKindOfClass:[UITextView class]])
    {
        ((UITextView *)self.targetObject).text = text;
    }
    else if([self.targetObject isKindOfClass:[UILabel class]])
    {
        ((UILabel *)self.targetObject).text = text;
    }
}

- (void)setTextToTargetWithAttString:(NSAttributedString *)text
{
    if ([self.targetObject isKindOfClass:[UITextView class]])
    {
        ((UITextView *)self.targetObject).attributedText = text;
    }
    else if([self.targetObject isKindOfClass:[UILabel class]])
    {
        ((UILabel *)self.targetObject).attributedText = text;
    }
}

@end
