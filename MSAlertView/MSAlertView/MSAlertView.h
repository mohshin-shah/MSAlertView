//
//  MSAlertViewContainer.h
//  MSAlertView
//
//  Created by Mohshin on 15/01/16.
//  Copyright © 2016 Mohshin. All rights reserved.
//
/*===========================================================*/
/*****                     MSAlertView                  *****/
/*=========================================================*/

#import <UIKit/UIKit.h>
#import "MSAlertViewController.h"

@class MSAlertView;
@protocol MSAlertViewDelegate <NSObject>

@optional

// Display customization can be done using these methods

/**
 * Informs the delegate that alert view is about to be visibled.
 * @author Mohshin Shah
 *
 * @param alertViewController Xib file owner.it is the controller object responsible for IBOutlets and related events.
 * @param superView Host view which will present the MSAlertView
 */
- (void)alertViewController:(id)alertViewController willDisplayAlertView:(UIView *)alertView fromSuperView:(UIView *)superView;

/**
 * Informs the delegate that alert view has been rendered successfully.
 * @author Mohshin Shah
 *
 * @param alertViewController Xib file owner.it is the controller object responsible for IBOutlets and related events.
 * @param superView Host view which will present the MSAlertView
 */
- (void)alertViewController:(id)alertViewController didDisplayAlertView:(UIView *)alertView fromSuperView:(UIView *)superView;

/**
 * Informs the delegate that alert view is about to be disappeared.
 * @author Mohshin Shah
 *
 * @param alertViewController Xib file owner.it is the controller object responsible for IBOutlets and related events.
 * @param superView Host view which will present the MSAlertView
 */
- (void)alertViewController:(id)alertViewController willHideAlertView:(UIView *)alertView fromSuperView:(UIView *)superView;

/**
 * Informs the delegate that alert view is not visible any more.
 * @author Mohshin Shah
 *
 * @param alertViewController Xib file owner.it is the controller object responsible for IBOutlets and related events.
 * @param superView Host view which will present the MSAlertView
 */
- (void)alertViewController:(id)alertViewController didHideAlertView:(UIView *)alertView fromSuperView:(UIView *)superView;

@end

@interface MSAlertView : NSObject

/**
 * Defines the MSAlertview size.Default is calculated using the screenheight/ screenwidth - margins(50 points).
 * @author Mohshin Shah
 */
@property (nonatomic) CGSize alertSize;

/**
 * The object that acts as a delegate of the MSAlertView.
 * @author Mohshin Shah
 */
@property (nonatomic, weak) id <MSAlertViewDelegate> delegate;

/**
 * Add new message between source to destination timeline as empty name string
 * @author Mohshin Shah
 *
 * @param nibFileName Nib file Name which is to be displayed
 * @param alertViewController it is the controller object responsible for IBOutlets and related events.
 * @param superView Host view which will present the MSAlertView
 * @return A newly created MSAlertView instance
 */
- (instancetype)initAlertViewUsing:(NSString *)nibFileName withViewController:(id)alertViewController inside:(UIView *)superView;

/**
 * Presents XIB as an AlertView floating on the screen.Which can be dimissed by tapping on the outside area.
 * @author Mohshin Shah
 * @param alertView it is the MSAlertView object to be shown.
 */
+ (void)showAlertView:(MSAlertView *)alertView;

/**
 * Dismiss the current MSAlertView presented on the screen.You can also dismiss the same by tapping outside the XIB.
 * @author Mohshin Shah
 * @param alertView it is the MSAlertView object to be hidden.

 */
+ (void)hideAlertView:(MSAlertView *)alertView;

@end