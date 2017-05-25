//
//  UIView+XCKit.m
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "UIView+XCKit.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UIDevice+XCDevice.h"

typedef void (^XC_WhenTappedBlock)();

@interface UIView (private)

- (void)runBlockForKey:(void *)blockKey;
- (void)setBlock:(XC_WhenTappedBlock)block forKey:(void *)blockKey;

- (UITapGestureRecognizer *)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector;
- (void)addRequirementToSingleTapsRecognizer:(UIGestureRecognizer *)recognizer;
- (void)addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer;

@end

@implementation UIView (XCKit)
static char KBadgeValue_static;
static char kWhenTappedBlockKey;
static char kWhenDoubleTappedBlockKey;
static char kWhenTwoFingerTappedBlockKey;
static char kWhenTouchedDownBlockKey;
static char kWhenTouchedUpBlockKey;

- (void)setXc_badgeValue:(NSString *)xc_badgeValue
{
    [self xc_clearBadgeValue];
    objc_setAssociatedObject(self, &KBadgeValue_static, xc_badgeValue, OBJC_ASSOCIATION_COPY);
    if (xc_badgeValue == nil) {
        [self xc_clearBadgeValue];
    }else{
        CGRect rect = [xc_badgeValue  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont smallSystemFontSize]]} context:nil];
        // 红点
        CGFloat badgeHeight = 0;
        UIButton * redBtn = [[UIButton alloc]init];
        if ([self xc_isAllNumber:xc_badgeValue]) {
            badgeHeight = 12;
            [redBtn setTitle:xc_badgeValue forState:UIControlStateNormal];
            redBtn.frame = CGRectMake(0, 0, rect.size.width > badgeHeight ? rect.size.width + 6 : badgeHeight, badgeHeight);
            redBtn.center = CGPointMake(self.frame.size.width / 2 + 30, badgeHeight / 2);
        }else{
            badgeHeight = 8;
            redBtn.frame = CGRectMake(0, 0, badgeHeight, badgeHeight);
            redBtn.center = CGPointMake(self.frame.size.width / 2 + 20, badgeHeight / 2);
        }
        redBtn.tag = 10086;
        redBtn.layer.cornerRadius = badgeHeight / 2;
        redBtn.layer.masksToBounds = YES;
        redBtn.titleLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        redBtn.backgroundColor = [UIColor redColor];
        [self addSubview:redBtn];
    }
}

- (NSString *)xc_badgeValue
{
    NSString *badgeValue = objc_getAssociatedObject(self, &KBadgeValue_static);
    if (badgeValue.integerValue <= 0) {
        return @"";
    }
    else{
        return badgeValue;
    }
}

#pragma mark --Private Method
- (void)xc_clearBadgeValue{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == 10086) {
            [view removeFromSuperview];
        }
    }
}

- (BOOL)xc_isAllNumber:(NSString *)text{
    unichar str;
    if (0 == text.length || text.integerValue <= 0) {
        return NO;
    }
    for (NSInteger index = 0; index < text.length; index ++) {
        str = [text characterAtIndex:index];
        if (isdigit(str)) {
            return YES;
        }
    }
    return NO;
}

- (void)runBlockForKey:(void *)blockKey {
	XC_WhenTappedBlock block = objc_getAssociatedObject(self, blockKey);

	if (block) block();
}

- (void)setBlock:(XC_WhenTappedBlock)block forKey:(void *)blockKey {
	self.userInteractionEnabled = YES;
	objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)whenTapped:(XC_WhenTappedBlock)block {
	UITapGestureRecognizer *gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped)];

	[self addRequiredToDoubleTapsRecognizer:gesture];
	[self setBlock:block forKey:&kWhenTappedBlockKey];
}

- (void)whenDoubleTapped:(XC_WhenTappedBlock)block {
	UITapGestureRecognizer *gesture = [self addTapGestureRecognizerWithTaps:2 touches:1 selector:@selector(viewWasDoubleTapped)];

	[self addRequirementToSingleTapsRecognizer:gesture];
	[self setBlock:block forKey:&kWhenDoubleTappedBlockKey];
}

- (void)whenTwoFingerTapped:(XC_WhenTappedBlock)block {
	[self addTapGestureRecognizerWithTaps:1 touches:2 selector:@selector(viewWasTwoFingerTapped)];
	[self setBlock:block forKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)whenTouchedDown:(XC_WhenTappedBlock)block {
	[self setBlock:block forKey:&kWhenTouchedDownBlockKey];
}

- (void)whenTouchedUp:(XC_WhenTappedBlock)block {
	[self setBlock:block forKey:&kWhenTouchedUpBlockKey];
}

- (void)viewWasTapped {
	[self runBlockForKey:&kWhenTappedBlockKey];
}

- (void)viewWasDoubleTapped {
	[self runBlockForKey:&kWhenDoubleTappedBlockKey];
}

- (void)viewWasTwoFingerTapped {
	[self runBlockForKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	[self runBlockForKey:&kWhenTouchedDownBlockKey];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	[self runBlockForKey:&kWhenTouchedUpBlockKey];
}

- (UITapGestureRecognizer *)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];

	tapGesture.delegate = self;
	tapGesture.numberOfTapsRequired = taps;
	tapGesture.numberOfTouchesRequired = touches;
	[self addGestureRecognizer:tapGesture];
	return tapGesture;
}

- (void)addRequirementToSingleTapsRecognizer:(UIGestureRecognizer *)recognizer {
	for (UIGestureRecognizer *gesture in[self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;

			if (tapGesture.numberOfTouchesRequired == 1 && tapGesture.numberOfTapsRequired == 1) {
				[tapGesture requireGestureRecognizerToFail:recognizer];
			}
		}
	}
}

- (void)addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer {
	for (UIGestureRecognizer *gesture in[self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;

			if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
				[recognizer requireGestureRecognizerToFail:tapGesture];
			}
		}
	}
}

+ (UIView *)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
	UIView *view = [[UIView alloc] initWithFrame:frame];
	[view setBackgroundColor:backgroundColor];

	return view;
}

+ (UIView*)viewFromNib
{
    __weak id wSelf = self;
    
    // There is a swift bug, compiler will add a package name in front of the class name
    NSString *className = NSStringFromClass(self);
    NSArray *components = [className componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    className = [components lastObject];
    
    return [[[[UINib nibWithNibName:className bundle:[NSBundle bundleForClass:self]] instantiateWithOwner:nil options:nil] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:wSelf];
    }]] lastObject];
}

// Borders
- (void)createBordersWithColor:(UIColor *)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width {
	self.layer.borderWidth = width;
	self.layer.cornerRadius = radius;
	self.layer.shouldRasterize = NO;
	self.layer.rasterizationScale = 2;
	self.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
	self.clipsToBounds = YES;
	self.layer.masksToBounds = YES;

	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGColorRef cgColor = [color CGColor];
	self.layer.borderColor = cgColor;
	CGColorSpaceRelease(space);
}

- (void)removeBorders {
	self.layer.borderWidth = 0;
	self.layer.cornerRadius = 0;
	self.layer.borderColor = nil;
}

- (void)removeShadow {
	[self.layer setShadowColor:[[UIColor clearColor] CGColor]];
	[self.layer setShadowOpacity:0.0f];
	[self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
}

- (void)setCornerRadius:(CGFloat)radius {
	self.layer.cornerRadius = radius;
	[self.layer setMasksToBounds:YES];
}

// Shadows
- (void)createRectShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOpacity = opacity;
	self.layer.shadowOffset = offset;
	self.layer.shadowRadius = radius;
	self.layer.masksToBounds = NO;
}

- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOpacity = opacity;
	self.layer.shadowOffset = offset;
	self.layer.shadowRadius = radius;
	self.layer.shouldRasterize = YES;
	self.layer.cornerRadius = cornerRadius;
	self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:cornerRadius] CGPath];
	self.layer.masksToBounds = NO;
}

// Animations
- (void)shakeView {
	CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
	shake.autoreverses = YES;
	shake.repeatCount = 2.0f;
	shake.duration = 0.07f;

	[self.layer addAnimation:shake forKey:nil];
}

- (void)pulseViewWithTime:(CGFloat)seconds {
	[UIView animateWithDuration:seconds / 6 animations: ^{
	    [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
	} completion: ^(BOOL finished) {
	    if (finished) {
	        [UIView animateWithDuration:seconds / 6 animations: ^{
	            [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
			} completion: ^(BOOL finished) {
	            if (finished) {
	                [UIView animateWithDuration:seconds / 6 animations: ^{
	                    [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
					} completion: ^(BOOL finished) {
	                    if (finished) {
	                        [UIView animateWithDuration:seconds / 6 animations: ^{
	                            [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
							} completion: ^(BOOL finished) {
	                            if (finished) {
	                                [UIView animateWithDuration:seconds / 6 animations: ^{
	                                    [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
									} completion: ^(BOOL finished) {
	                                    if (finished) {
	                                        [UIView animateWithDuration:seconds / 6 animations: ^{
	                                            [self setTransform:CGAffineTransformMakeScale(1, 1)];
											} completion: ^(BOOL finished) {
	                                            if (finished) {
												}
											}];
										}
									}];
								}
							}];
						}
					}];
				}
			}];
		}
	}];
}

- (UIImage *)takeScreenshot {
	// Source (Under MIT License): https://github.com/shinydevelopment/SDScreenshotCapture/blob/master/SDScreenshotCapture/SDScreenshotCapture.m#L35

	BOOL ignoreOrientation = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");

	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

	CGSize imageSize = CGSizeZero;
	if (UIInterfaceOrientationIsPortrait(orientation) || ignoreOrientation)
		imageSize = [UIScreen mainScreen].bounds.size;
	else
		imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);

	UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, self.center.x, self.center.y);
	CGContextConcatCTM(context, self.transform);
	CGContextTranslateCTM(context, -self.bounds.size.width * self.layer.anchorPoint.x, -self.bounds.size.height * self.layer.anchorPoint.y);

	// Correct for the screen orientation
	if (!ignoreOrientation) {
		if (orientation == UIInterfaceOrientationLandscapeLeft) {
			CGContextRotateCTM(context, (CGFloat)M_PI_2);
			CGContextTranslateCTM(context, 0, -imageSize.width);
		}
		else if (orientation == UIInterfaceOrientationLandscapeRight) {
			CGContextRotateCTM(context, (CGFloat) - M_PI_2);
			CGContextTranslateCTM(context, -imageSize.height, 0);
		}
		else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
			CGContextRotateCTM(context, (CGFloat)M_PI);
			CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
		}
	}

	if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
		[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
	else
		[self.layer renderInContext:UIGraphicsGetCurrentContext()];

	CGContextRestoreGState(context);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

- (NSArray *)allSuperviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];
	UIView *view = self;
	UIView *superview = nil;

	while (view) {
		superview = [view superview];

		if (!superview) {
			break;
		}

		[superviews addObject:superview];
		view = superview;
	}
	return superviews;
}

- (NSArray *)allSubviews {
	NSArray *results = [self subviews];

	for (UIView *eachView in[self subviews]) {
		NSArray *riz = [eachView allSubviews];

		if (riz) {
			results = [results arrayByAddingObjectsFromArray:riz];
		}
	}

	return results;
}

- (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

	maskLayer.frame = self.bounds;
	maskLayer.path = maskPath.CGPath;
	self.layer.mask = maskLayer;
}

- (void)removeAllSubviews {
	UIView *view;
	NSArray *subviews = [self subviews];
	NSUInteger i = [subviews count];

	for (; i > 0; --i) {
		view = [subviews objectAtIndex:(i - 1)];
		[view removeFromSuperview];
	}
}

- (UIViewController *)belongViewController {
	for (UIView *next = [self superview]; next; next = next.superview) {
		UIResponder *nextResponder = [next nextResponder];

		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			return (UIViewController *)nextResponder;
		}
	}

	return nil;
}

- (CGPoint)xc_origin {
	return self.frame.origin;
}

- (void)setXc_origin:(CGPoint)xc_origin {
	self.frame = CGRectMake(xc_origin.x, xc_origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setXc_size:(CGSize)xc_size {
	CGPoint origin = [self frame].origin;

	[self setFrame:CGRectMake(origin.x, origin.y, xc_size.width, xc_size.height)];
}

- (CGSize)xc_size {
	return [self frame].size;
}

- (CGFloat)left {
	return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = [self frame];

	frame.origin.x = x;
	[self setFrame:frame];
}

- (CGFloat)top {
	return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y {
	CGRect frame = [self frame];

	frame.origin.y = y;
	[self setFrame:frame];
}

- (CGFloat)right {
	return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right {
	CGRect frame = [self frame];

	frame.origin.x = right - frame.size.width;

	[self setFrame:frame];
}

- (CGFloat)bottom {
	return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = [self frame];

	frame.origin.y = bottom - frame.size.height;
	[self setFrame:frame];
}

- (CGFloat)xc_centerX {
	return [self center].x;
}

- (void)setXc_centerX:(CGFloat)xc_centerX {
	[self setCenter:CGPointMake(xc_centerX, self.center.y)];
}

- (CGFloat)xc_centerY {
	return [self center].y;
}

- (void)setXc_centerY:(CGFloat)xc_centerY {
	[self setCenter:CGPointMake(self.center.x, xc_centerY)];
}

- (CGFloat)xc_width {
	return CGRectGetWidth([self frame]);
}

- (void)setXc_width:(CGFloat)xc_width {
	CGRect frame = [self frame];

	frame.size.width = xc_width;

	[self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)xc_height {
	return CGRectGetHeight([self frame]);
}

- (void)setXc_height:(CGFloat)xc_height {
	CGRect frame = [self frame];

	frame.size.height = xc_height;

	[self setFrame:CGRectStandardize(frame)];
}

- (void)bringToFront {
	[self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
	[self.superview sendSubviewToBack:self];
}

- (NSUInteger)indexOfSuperView {
	return [self.superview.subviews indexOfObject:self];
}

- (void)bringOneLevelUp {
	NSInteger currentIndex = [self indexOfSuperView];

	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex + 1];
}

- (void)sendOneLevelDown {
	NSInteger currentIndex = [self indexOfSuperView];

	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex - 1];
}

- (BOOL)isInFront {
	return ([self.superview.subviews lastObject] == self);
}

- (BOOL)isAtBack {
	return ([self.superview.subviews objectAtIndex:0] == self);
}

@end
