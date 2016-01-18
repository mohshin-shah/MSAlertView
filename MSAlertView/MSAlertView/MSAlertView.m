//
//  MSAlertViewContainer.m
//  MSAlertView
//
//  Created by Mohshin on 15/01/16.
//  Copyright © 2016 Mohshin. All rights reserved.
//

#import "MSAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define  kDefaultHorizontalMargin 50
#define  kDefaultVerticalMargin 50

@interface MSAlertView ()

@property (nonatomic, strong) UIView *nibView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *dimmedView;
@property (nonatomic, strong) NSArray *constraints;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic) id alertViewController;

@end

@implementation MSAlertView

#pragma mark - Class Methods

+ (void)showAlertView:(MSAlertView *)alertView
{
    [alertView showAlertView];
}

+ (void)hideAlertView:(MSAlertView *)alertView
{
    [alertView hideAlertView];
}


#pragma mark - Initialization

- (instancetype)initAlertViewUsing:(NSString *)nibFileName withViewController:(id)alertViewController inside:(UIView *)superView
{
    self = [super init];
    if (self) {
        
        /* XIB File Owner is required for handling @IBOutlets and their related events */
        NSAssert(alertViewController != nil, @"AlertViewController can not be nil.Please specify XIB's File Owner.");
        self.alertViewController = alertViewController;
        
        NSArray *xibViews = [[UINib nibWithNibName:nibFileName bundle:nil] instantiateWithOwner:self.alertViewController options:nil];
        
        NSString *xibViewError = [NSString stringWithFormat:@"There must be one view inside %@.xib",nibFileName];
        
        /* Check whether there's only one view or not */
        NSAssert([xibViews count] == 1,xibViewError);

        /* Assigning nibView */
        self.nibView = [[[UINib nibWithNibName:nibFileName bundle:nil] instantiateWithOwner:self.alertViewController options:nil] objectAtIndex:0];
        self.nibView.translatesAutoresizingMaskIntoConstraints = NO;
        
        /* Assigning superView */
        self.containerView = superView;
        
        /* Shadow Effect */
        self.nibView.layer.masksToBounds = NO;
        self.nibView.layer.shadowOffset = CGSizeMake(-1, 1);
        self.nibView.layer.shadowRadius = 50;
        self.nibView.layer.shadowOpacity = 0.5;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object:nil];

    }
    
    return self;
}

#pragma mark - Private Properties and Methods

- (void)showAlertView
{
    if ([self.delegate respondsToSelector:@selector(alertViewController:willDisplayAlertView:fromSuperView:)])[self.delegate alertViewController:self.alertViewController willDisplayAlertView:self.nibView fromSuperView:self.containerView];
    
    [UIView transitionWithView:self.containerView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve //any animation
                    animations:^
     {
         [self.containerView addSubview:self.nibView];
         [self.containerView insertSubview:self.dimmedView belowSubview:self.nibView];
         [self.containerView addConstraints:self.constraints];
         [self calculateAlertViewSize];
     } completion:^(BOOL finished)
     {
         if ([self.delegate respondsToSelector:@selector(alertViewController:didDisplayAlertView:fromSuperView:)])[self.delegate alertViewController:self.alertViewController didDisplayAlertView:self.nibView fromSuperView:self.containerView];
     }];
}

- (void)hideAlertView
{
    if ([self.delegate respondsToSelector:@selector(alertViewController:willHideAlertView:fromSuperView:)])[self.delegate alertViewController:self.alertViewController willHideAlertView:self.nibView fromSuperView:self.containerView];
    
    [UIView transitionWithView:self.containerView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^
     {
         [self.nibView removeFromSuperview];
         [self.dimmedView removeFromSuperview];
     } completion:^(BOOL finished)
     {
         if ([self.delegate respondsToSelector:@selector(alertViewController:didHideAlertView:fromSuperView:)])[self.delegate alertViewController:self.alertViewController didHideAlertView:self.nibView fromSuperView:self.containerView];
     }];
    
}

- (void)dimmedViewTapped:(UITapGestureRecognizer *)recognizer
{
    /* Hide the alertView while tapping the outside area(dimmedView). */
    [self hideAlertView];
}

/*===========================================================*/
/*****              Private Properties                  *****/
/*=========================================================*/

- (UIView *)dimmedView
{
    if (!_dimmedView)
    {
        _dimmedView = [[UIView alloc] initWithFrame:self.containerView.frame];
        _dimmedView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
        [_dimmedView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmedViewTapped:)]];
    }
    return _dimmedView;
}

- (NSArray *)constraints
{
    if (!_constraints)
    {
     
        _constraints = @[[NSLayoutConstraint constraintWithItem:self.nibView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
                         
                         [NSLayoutConstraint constraintWithItem:self.nibView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
                         self.widthConstraint,
                         self.heightConstraint];
    }
    return _constraints;
}

- (NSLayoutConstraint *)heightConstraint
{
    if (!_heightConstraint)
    {
        
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self.nibView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0
                                                          constant:self.alertSize.height];
    }
    return _heightConstraint;
}

- (NSLayoutConstraint *)widthConstraint
{
    if (!_widthConstraint)
    {
        _widthConstraint = [NSLayoutConstraint constraintWithItem:self.nibView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.alertSize.width];
    }
    return _widthConstraint;

}

- (CGSize)alertSize
{
    if (CGSizeEqualToSize(CGSizeZero, _alertSize))
    {
        _alertSize = [self defaultAlertSize];
    }
    return _alertSize;
}

/*  Handling Device Orientation Notification */
- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    [self calculateAlertViewSize];
}

- (void)calculateAlertViewSize
{
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (UIDeviceOrientationIsPortrait(orientation))
    {
        /* Portrait : Related Constraint Changes */
        self.heightConstraint.constant = self.alertSize.height;
        self.widthConstraint.constant = self.alertSize.width;
    }
    else
    {
        /* Landscape : Related Constraint Changes */
        self.heightConstraint.constant = self.alertSize.width;
        self.widthConstraint.constant = self.alertSize.height;
    }
    
    /* Whenever the orientation changes dimmedView should change its frame */
    self.dimmedView.frame = self.containerView.frame;
    
}

- (CGSize)defaultAlertSize
{
    /* Screen size */
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    /* Default alertsize calculated based on the orientation and margin */
    return CGSizeMake(MIN(screenSize.width, screenSize.height) - kDefaultHorizontalMargin, MAX(screenSize.width, screenSize.height) - kDefaultVerticalMargin);
}

@end
