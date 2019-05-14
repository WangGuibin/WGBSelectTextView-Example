//
//  WGBEnglishWordTextView.m
//  SelectTextView
//
//  Created by 王贵彬 on 2019/5/14.
//  Copyright © 2019 王贵彬. All rights reserved.
//

#import "WGBEnglishWordTextView.h"

@implementation WGBEnglishWordTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectable = NO;//关闭系统的编辑以及选中
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction:)];
        [self addGestureRecognizer: tapGes];
        
        UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickTextAction:)];
        longPressGes.minimumPressDuration = 1.0f;
        [self addGestureRecognizer: longPressGes];
        //两种手势共存 但是是以长按失败为准的 达不到长按的条件 那只能是点击了
        [tapGes requireGestureRecognizerToFail: longPressGes];
        
    }
    return self;
}


- (void)tapClickAction:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");
    
}

- (void)clickTextAction:(UILongPressGestureRecognizer *)longGes{
    if (longGes.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按了1秒了");
    //获取当前触摸位置的字符所属的字母(提示：触摸位置需向下调整10个点，以便与文本元素对齐)
        CGPoint touchPoint = [longGes locationInView:self];
        touchPoint.y -= 10;
        
        // 获取点击的字母的位置
        NSInteger characterIndex = [self.layoutManager characterIndexForPoint:touchPoint inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
        
        // 获取单词的范围。range 由起始位置和长度构成。
        NSRange range = [self getWordRange:characterIndex];
        
        // 高亮单词
        [self modifyAttributeInRange:range];
        NSString *allText =  self.attributedText.string;
        NSString *wordStr = [allText substringWithRange: range];
        !self.selectTextBlock? : self.selectTextBlock(wordStr);
    }
}

//本来找的demo是点击的 产品要求要长按 点击做其他事.... so 先注释了
// 重写触摸开始函数
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
////获取当前触摸位置的字符所属的字母(提示：触摸位置需向下调整10个点，以便与文本元素对齐)
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self];
//    touchPoint.y -= 10;
//
//    // 获取点击的字母的位置
//    NSInteger characterIndex = [self.layoutManager characterIndexForPoint:touchPoint inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
//
//    // 获取单词的范围。range 由起始位置和长度构成。
//    NSRange range = [self getWordRange:characterIndex];
//
//    // 高亮单词
//    [self modifyAttributeInRange:range];
//    NSString *allText =  self.attributedText.string;
//    NSString *wordStr = [allText substringWithRange: range];
//    !self.selectTextBlock? : self.selectTextBlock(wordStr);
//
//    //调用父类的方法
//    [super touchesBegan: touches withEvent: event];
//}

//获取单词的范围
- (NSRange)getWordRange:(NSInteger)characterIndex {
    NSInteger left = characterIndex - 1;
    NSInteger right = characterIndex + 1;
    NSInteger length = 0;
    NSString *string = self.attributedText.string;
    
    // 往左遍历直到空格
    while (left >=0) {
        NSString *s=[string substringWithRange:NSMakeRange(left, 1)];
        
        if ([self isLetter:s]) {
            left --;
        } else {
            break;
        }
    }
    
    // 往右遍历直到空格
    while (right < self.text.length) {
        NSString *s=[string substringWithRange:NSMakeRange(right, 1)];
        
        if ([self isLetter:s]) {
            right ++;
        } else {
            break;
        }
    }
    
    // 此时 left 和 right 都指向空格
    left ++;
    right --;
//    NSLog(@"letf = %ld, right = %ld",left,right);
    
    length = right - left + 1;
    NSRange range = NSMakeRange(left, length);
    
    return range;
}

//判断是否字母
- (BOOL)isLetter:(NSString *)str {
    char letter = [str characterAtIndex:0];
    
    if ((letter >= 'a' && letter <='z') || (letter >= 'A' && letter <= 'Z')) {
        return YES;
    }
    return NO;
}

//修改属性字符串
- (void)modifyAttributeInRange:(NSRange)range {
    NSString *string = self.attributedText.string;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    //添加文字颜色
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    //添加文字背景颜色
    [attString addAttribute:NSBackgroundColorAttributeName value:[UIColor orangeColor] range:range];
    self.attributedText = attString;
}


@end
