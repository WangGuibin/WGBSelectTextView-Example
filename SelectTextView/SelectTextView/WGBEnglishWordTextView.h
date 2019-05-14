//
//  WGBEnglishWordTextView.h
//  SelectTextView
//
//  Created by 王贵彬 on 2019/5/14.
//  Copyright © 2019 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGBEnglishWordTextView : UITextView

@property (nonatomic,copy) void (^selectTextBlock)(NSString *text);


@end

NS_ASSUME_NONNULL_END
