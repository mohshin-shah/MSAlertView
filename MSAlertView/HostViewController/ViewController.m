//
//  ViewController.m
//  MSAlertView
//
//  Created by Mohshin on 15/01/16.
//  Copyright © 2016 Mohshin. All rights reserved.
//

#import "ViewController.h"
#define MSLog NSLog(@"%@", NSStringFromSelector(_cmd))

@interface ViewController () <MSAlertViewDelegate>

@end

@implementation ViewController

- (IBAction)btnShowAlertTapped:(id)sender
{
    //Presenting the Login AlertView
    [MSAlertView showAlertView:self.msAlertView];
}

-(IBAction)showShoppingCart:(id)sender
{
    //Presenting the Shopping Cart AlertView
    [MSAlertView showAlertView:self.msShoppingCartView];
}

- (MSAlertViewController *)msAlertViewController
{
    /*===========================================================*/
    /*****                 MSAlertViewController            *****/
    /*=========================================================*/
    if (!_msAlertViewController) {
        /* View will be automatically binded by MSAlertView using the XIB name. */
        _msAlertViewController  = [[MSAlertViewController alloc] init];
    }
    return _msAlertViewController;
}

- (MSShoppingCart *)shoppingCartViewController
{
    /*===========================================================*/
    /*****              MSShoppingCart ViewController       *****/
    /*=========================================================*/
    if (!_shoppingCartViewController) {
        /* View will be automatically binded by MSAlertView using the XIB name. */
        _shoppingCartViewController  = [[MSShoppingCart alloc] init];
    }
    return _shoppingCartViewController;
}


- (MSAlertView *)msAlertView
{
    if (!_msAlertView) {
        
        /* Configuring Login alertview using the viewcontroller object and size */
        _msAlertView = [[MSAlertView alloc] initAlertViewUsing:@"MSLoginExample" withViewController:self.msAlertViewController inside:self.view];// XIB will be binded to the ViewController Object
        
        /* Size can be specified using the alertSize property*/
        //_msAlertView.alertSize = CGSizeMake(self.view.frame.size.width - 60, self.view.frame.size.height - 100);
        _msAlertView.delegate = self;

    }
    return _msAlertView;
}

- (MSAlertView *)msShoppingCartView
{
    if (!_msShoppingCartView) {
        
        /* Configuring shopping cart alertview using the viewcontroller object and size */
        _msShoppingCartView = [[MSAlertView alloc] initAlertViewUsing:@"MSShoppingCart" withViewController:self.shoppingCartViewController inside:self.view]; // XIB will be binded to the ViewController Object
        
        /* Size can be specified using the alertSize property */
        //_msShoppingCartView.alertSize = CGSizeMake(self.view.frame.size.width - 70, self.view.frame.size.height - 100);
        
        _msShoppingCartView.delegate = self;
    }
    return _msShoppingCartView;
}

-(void)alertViewController:(id)alertViewController didDisplayAlertView:(UIView *)alertView fromSuperView:(UIView *)superView
{
    MSLog;
}

-(void)alertViewController:(id)alertViewController didHideAlertView:(UIView *)alertView fromSuperView:(UIView *)superView
{
    MSLog;
}

-(void)alertViewController:(id)alertViewController willDisplayAlertView:(UIView *)alertView fromSuperView:(UIView *)superView
{
    MSLog;
}

-(void)alertViewController:(id)alertViewController willHideAlertView:(UIView *)alertView fromSuperView:(UIView *)superView
{
    MSLog;
}

@end
