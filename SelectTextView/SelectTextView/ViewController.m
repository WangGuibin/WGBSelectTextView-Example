//
//  ViewController.m
//  SelectTextView
//
//  Created by 王贵彬 on 2019/5/14.
//  Copyright © 2019 王贵彬. All rights reserved.
//

#import "ViewController.h"
#import "WGBEnglishWordTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
    WGBEnglishWordTextView *textView = [[WGBEnglishWordTextView alloc]initWithFrame:frame];
    textView.editable = NO;
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    NSString *string = @"The UIFont class provides the interface for getting and setting font information. The class provides you with access to the font’s characteristics and also provides the system with access to the font’s glyph information, which is used during layout. You use font objects by passing them to methods that accept them as a parameter.";
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    textView.attributedText = attrStr;
    [textView setSelectTextBlock:^(NSString * _Nonnull text) {
        NSLog(@"%@",text);
    }];

}


@end
