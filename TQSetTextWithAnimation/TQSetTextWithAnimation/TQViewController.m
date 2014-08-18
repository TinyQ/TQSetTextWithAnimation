//
//  TQViewController.m
//  TQSetTextWithAnimation
//
//  Created by qfu on 8/18/14.
//  Copyright (c) 2014 tinyq. All rights reserved.
//

#import "TQViewController.h"
#import "TQSetTextWithAnimationHelper.h"

@interface TQViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic,strong) TQSetTextWithAnimationHelper *textViewHelper;

@property (nonatomic,strong) TQSetTextWithAnimationHelper *labelViewHelper;
@end

@implementation TQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textViewHelper = [[TQSetTextWithAnimationHelper alloc] initWithTarget:self.textView];
    self.labelViewHelper = [[TQSetTextWithAnimationHelper alloc] initWithTarget:self.textLabel];
}

- (IBAction)buttonTouchUpInside:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSString *testString = @"你好今天天气不错";
    
    NSString *testString1 = @"你好今天天气不错，确实不错的呀。";
    
    if (button.tag == 0)
    {
        [self.textViewHelper setTextWithString:testString];
        [self.textViewHelper setTextWithString:testString1];
    }
    
    if (button.tag == 1)
    {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:testString];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attString.length)];
        
        NSMutableAttributedString *attString1 = [[NSMutableAttributedString alloc] initWithString:testString1];
        [attString1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attString1.length)];
        
        NSArray *arrStringArray = @[attString,attString1];
        
        for (int i = 0; i < arrStringArray.count; i++)
        {
            [self.labelViewHelper setTextWithAttString:arrStringArray[i]];
        }
    }
}

@end
