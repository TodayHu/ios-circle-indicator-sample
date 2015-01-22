//
//  WearableAction.h
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

@protocol WearableAction @end

/*!
 * @class WearableAction
 *
 * @discussion Actions that can will only be available on a wearable device, not on the 
 * handheld/phone.
 */
@interface WearableAction : JSONModel  <NSCoding>

/*!
 * @discussion Title to be used with this wearable actions
 */
@property (nonatomic, retain) NSString *title;

/*!
 *  @discussion The Action Icon.  Must be a name of an exiting image in your resources.
 */
@property (nonatomic, retain) NSString *icon;

/*!
 *  @discussion Name of controller to launch when user selects the action.
 */
@property (nonatomic, retain) NSString *actionIntentName;
@end
