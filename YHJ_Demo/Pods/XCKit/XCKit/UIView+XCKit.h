//
//  UIView+XCKit.h
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XCKit) <UIGestureRecognizerDelegate>

/**
 *  @author liuxiaochun
 *
 *  设置消息数，设置小于或等于0 、@"" 或 不规则字符 为实心圆,  nil 就是隐藏
 */
@property (nonatomic,copy,readwrite) NSString* xc_badgeValue;

/**
 *  Return it's origin
 */
@property (nonatomic, assign) CGPoint xc_origin;

/**
 *  Return it's size
 */
@property (nonatomic, assign) CGSize xc_size;

/**
 *  Return it's left position
 */
@property (nonatomic, assign) CGFloat left;

/**
 *  Return it's right position
 */
@property (nonatomic, assign) CGFloat right;

/**
 *  Return it's top position
 */
@property (nonatomic, assign) CGFloat top;

/**
 *  Return it's bottom position
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 *  Return it's center position on X alas
 */
@property (nonatomic, assign) CGFloat xc_centerX;

/**
 *  Return it's center position on Y alas
 */
@property (nonatomic, assign) CGFloat xc_centerY;

/**
 *  Return it's width
 */
@property (nonatomic, assign) CGFloat xc_width;

/**
 *  Return it's height
 */
@property (nonatomic, assign) CGFloat xc_height;

/**
 *  Return YES it's front level
 */
@property (nonatomic, readonly, getter = isInFront) BOOL inFront;

/**
 *  Return YES it's back level
 */
@property (nonatomic, readonly, getter = isAtBack) BOOL atBack;

/**
 *  Take a screenshot of current window
 *
 *  @return Return the screenshot as an UIImage
 */
- (UIImage *)takeScreenshot;

/**
 *  Create an UIView with the given frame and background color
 *
 *  @param frame           UIView's frame
 *  @param backgroundColor UIView's background color
 */
+ (UIView *)initWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)backgroundColor;

/**
 *  Create an UIView from Nib file
 */
+ (UIView *)viewFromNib;

/**
 *  Create a border around the UIView
 *
 *  @param color  Border's color
 *  @param radius Border's radius
 *  @param width  Border's width
 */
- (void)createBordersWithColor:(UIColor *)color
              withCornerRadius:(CGFloat)radius
                      andWidth:(CGFloat)width;

/**
 *  Remove the borders around the UIView
 */
- (void)removeBorders;

/**
 *  Create a shadow on the UIView
 *
 *  @param offset  Shadow's offset
 *  @param opacity Shadow's opacity
 *  @param radius  Shadow's radius
 */
- (void)createRectShadowWithOffset:(CGSize)offset
                           opacity:(CGFloat)opacity
                            radius:(CGFloat)radius;

/**
 *  Create a corner radius shadow on the UIView
 *
 *  @param cornerRadius Corner radius value
 *  @param offset       Shadow's offset
 *  @param opacity      Shadow's opacity
 *  @param radius       Shadow's radius
 */
- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                          offset:(CGSize)offset
                                         opacity:(CGFloat)opacity
                                          radius:(CGFloat)radius;

/**
 *  Remove the shadow around the UIView
 */
- (void)removeShadow;

/**
 *  Set the corner radius of UIView
 *
 *  @param radius Radius value
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  Create a shake effect on the UIView
 */
- (void)shakeView;

/**
 *  Create a pulse effect on th UIView
 *
 *  @param seconds Seconds of animation
 */
- (void)pulseViewWithTime:(CGFloat)seconds;

/**
 *  Return super view whole
 *
 *  @return Return super view whole
 */
- (NSArray *)allSuperviews;

/**
 *  Remove subviews
 */
- (void)removeAllSubviews;

/**
 *  Return allsubviews
 *
 *  @return Return array with subviews
 */
- (NSArray *)allSubviews;

/**
 *  Return belong viewcontroller
 *
 *  @return Return UIViewController instance
 */
- (UIViewController *)belongViewController;

/**
 *  Bring it to front level
 */
- (void)bringToFront;

/**
 *  Send it to back level
 */
- (void)sendToBack;

/**
 *  upgrade it one level
 */
- (void)bringOneLevelUp;

/**
 *  downgrade it one level
 */
- (void)sendOneLevelDown;

/**
 *  whe single tapped
 *
 *  @param block block
 */
- (void)whenTapped:(void (^)())block;

/**
 *  whe double tapped
 *
 *  @param block block
 */
- (void)whenDoubleTapped:(void (^)())block;

/**
 *  whe tow finder tapped
 *
 *  @param block block
 */
- (void)whenTwoFingerTapped:(void (^)())block;

/**
 *  whe touched down
 *
 *  @param block block
 */
- (void)whenTouchedDown:(void (^)())block;

/**
 *  whe touched up
 *
 *  @param block block
 */
- (void)whenTouchedUp:(void (^)())block;

@end
