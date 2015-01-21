//
//  GlanceStyle.h
//  IWApp
//
//  Created by Osmon, Cindy on 1/2/15.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <Foundation/Foundation.h>
#import <IntuitWearKit/JSONModel.h>

/*!
 * @class GlanceStyle
 *
 * @discussion Notification Style that represents a radial graph much like the Apple 
 *             Watch Activity App.
 */
@interface GlanceStyle : JSONModel  <NSCoding> 

/*!
 * @discussion Integer representing the color of the circle to draw. 
 *             Current values are 0 = Red, 1 = Green
 */

@property (nonatomic) NSInteger glanceColor;

/*!
 * @discussion Header text that will be drawn in the Group above the Circle.
 */
@property (nonatomic, retain) NSString<Optional>* glanceHeaderLabelText;

/*!
 * @discussion First line of text that is drawn in the center of the Circle.
 */
@property (nonatomic, retain) NSString<Optional>* glanceInnerLabelText;

/*!
 * @discussion Second line of sub text that is drawn in the center of the Circle.
 */
@property (nonatomic, retain) NSString<Optional>* glanceInnerSubLabelText;

/*!
 * @discussion Total number of segments in the circle (i.e. Total number of images).
 */
@property (nonatomic) NSInteger glanceTotalItemCount;

/*!
 * @discussion Number of completed items which will determine the number of images
 *             drawn.
 */
@property (nonatomic) NSInteger glanceCompletedItemsCount;

@end
