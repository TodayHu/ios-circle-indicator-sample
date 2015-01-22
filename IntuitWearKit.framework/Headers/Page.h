//
//  Page.h
//  IntuitWear
//
//  Created by Osmon, Cindy on 12/20/14.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.

#import <Foundation/Foundation.h>
#import <IntuitWearKit/JSONModel.h>

@protocol Page @end

/*!
 * @class Page
 *
 * @discussion Page declaration for multi-page notifications
 */
@interface Page : JSONModel  <NSCoding>

/*!
 * @discussion Title for this page
 */
@property (nonatomic, retain) NSString *pageTitle;

/*!
 * @discussion Text content for this page, e.g. HTML encoded text
 */
@property (nonatomic, retain) NSString *pageText;

/*!
 * @discussion Name of resource to use for the background of the page. NOTE: This resource must already exist.
 */
@property (nonatomic, retain) NSString<Optional> *pageBackground;

- (instancetype)init;
@end
