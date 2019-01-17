//
//  UIViewController+Swizzled.h
//  AppCodeAnalysis
//
//  Created by ldh on 2019/1/17.
//  Copyright © 2019年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SWIZZ_IT [UIViewController swizzIt];
#define SWIZZ_IT_WITH_TAG(tag) [UIViewController swizzItWithTag:tag];

#define UN_SWIZZ_IT [UIViewController undoSwizz];

@interface UIViewController (Swizzled)

+ (void)swizzIt;

+ (void)swizzItWithTag:(NSString *)tag;

+ (void)undoSwizz;
@end
