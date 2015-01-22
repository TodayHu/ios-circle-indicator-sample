//
//  Action.h
//  IntuitWear
//
//  Created by Osmon, Cindy on 12/20/14.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <Foundation/Foundation.h>
#import <IntuitWearKit/JSONModel.h>

@protocol Action @end

/*!
 * @class Action
 *
 * @discussion Actions that can be triggered by a Notification
 */
@interface Action : JSONModel  <NSCoding>

/*!
 * @discussion The name of the action icon.  On iOS this must be a name of an existing icon.
 */
@property (nonatomic, retain) NSString *icon;

/*!
 * @discussion The name displayed on the action button.
 */
@property (nonatomic, retain) NSString *actionName;

/**
 *  @discussion The name of the controller to launch when the action is selected.
 */
@property (nonatomic, retain) NSString *intentName;

@end
