//
//  MSShoppingCart.m
//  MSAlertView
//
//  Created by Mohshin Shah on 16/01/16.
//  Copyright © 2016 Mohshin. All rights reserved.
//

#import "MSShoppingCart.h"

@interface MSShoppingCart ()<UITableViewDataSource , UITableViewDelegate>

@end

@implementation MSShoppingCart

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"Shopping Item %ld",(long)indexPath.row]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Lorem Ipsum Lorem Ipsum and Lorem Ipsum"]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    [cell.detailTextLabel setTextColor:[UIColor grayColor]];

    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    NSString *headerTitle;
    if (section==0) {
        headerTitle = @"Checkout List";
    }
    else{
        headerTitle = @"Wishlist Items";
        
    }
    return headerTitle;
}

@end
