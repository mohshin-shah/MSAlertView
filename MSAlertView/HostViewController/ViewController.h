//
//  ViewController.h
//  MSAlertView
//
//  Created by Mohshin Shah on 15/01/16.
//  Copyright © 2016 Mohshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAlertView.h"
#import "MSShoppingCart.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) MSAlertView *msAlertView,*msShoppingCartView;
@property (nonatomic, strong) MSAlertViewController *msAlertViewController;

//You can have UIViewController as the AlertViewController
@property (nonatomic, strong) MSShoppingCart *shoppingCartViewController;



@end

