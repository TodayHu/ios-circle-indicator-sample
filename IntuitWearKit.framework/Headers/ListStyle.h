//
//  ListStyle.h
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

/*!
 * @class ListStyle
 *
 * @discussion This style supports a vertically scrolling item list of items
 *             that can be selected with voice or physically tapped.
 */
@interface ListStyle : JSONModel  <NSCoding>

/*!
 * @discussion Name of icon that a represents recording icon
 */
@property (nonatomic, retain) NSString *icon;

/*!
 *  @discussion Content Title for a ListStyle notification
 */
@property (nonatomic, retain) NSString *title;

/*!
 * @discussion A label that will be shown close to recording icon
 */
@property (nonatomic, retain) NSString *label;

/*!
 * @discussion Controller to be called with the selected item
 */
@property (nonatomic, retain) NSString *intentName;

/*!
 * @discussion Single select list of items made available for speech recognition
 */
@property (nonatomic, retain) NSArray *items;

@end
