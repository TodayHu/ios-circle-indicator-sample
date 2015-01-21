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
@end
