//
//  GlanceWidgetStyle.h
//  IWApp
//
//  Created by Osmon, Cindy on 1/2/15.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//

#import <Foundation/Foundation.h>
#import <IntuitWearKit/GlanceStyle.h>

@import WatchKit;

/*!
 * @class IWGlanceCircleIndicator
 *
 * @discussion This class draws a radial graph of a given color with text in the
 *        middle of the circle much like you see on the Apple Watch Acitivity App.
 */
@interface IWGlanceCircleIndicator : NSObject

/*!
 * @discussion The string value of the color of the circle to be drawn.
 *             Current values are only "Red", "Green".
 */
@property (nonatomic, retain) NSString *glanceColor;

/*!
 * @discussion The header text shown in the Group above the circle.
 */

@property (nonatomic, retain) NSString *glanceHeaderText;

/*!
 *  Initializes the IWGlanceCircleIndicator with the data from GlanceStyle.
 *
 *  @param glanceStyle The GlanceStyle object that contains all of the
 *                     IWGlanceCiricleIndicator parameters
 *
 *  @return The IWGlanceCircleIndicator object that handles building the circle
 *         indicator and it's data
 */
- (instancetype)initWithGlanceStyle:(GlanceStyle *)glanceStyle;

/*!
 *  Initializes the IWGlanceCircularIndicator with an initial total item count
 *  and the number of completed items.
 *
 *  @param totalItemCount    The total number of items that represent a full circle.
 *  @param completeItemCount The number of items completed out of the total item count.
 *
 *  @return The IWGlanceCircleIndicator object that handles building the circle
 *          indicator and it's data
 */
- (instancetype)initWithTotalItemCount:(NSInteger)totalItemCount completeItemCount:(NSInteger)completeItemCount;

/*!
 *  Initializes the IWGlanceCircularIndicator with an initial total item count
 *  and the number of completed items and an integer represent the color you
 *  wish the circle to be drawn in as defined by the NS_ENUM IWGlanceColor.
 *
 *  @param totalItemCount    The total number of items that represent a full circle.
 *  @param completeItemCount The number of items completed out of the total item count.
 *  @param color             NS_ENUM IWGlanceColor representing the color of the circle to be drawn.
 *
 *  @return The IWGlanceCircleIndicator object that handles building the circle
 *         indicator and it's data
 */
- (instancetype)initWithTotalItemCountAndColor:(NSInteger)totalItemCount completeItemCount:(NSInteger)completeItemCount color:(NSInteger)color;

/// The total number of items.
@property (readonly) NSInteger totalItemCount;

/// The number of completed items.
@property (readonly) NSInteger completeItemCount;

/// The number of incomplete items.
@property (readonly) NSInteger incompleteItemCount;

/// The image name of the image to be used for the Glance widget.
@property (readonly) NSString *imageName;

/// The range of images to display in the Glance widget.
@property (readonly) NSRange imageRange;

/// The length that the Glance widget image will animate.
@property (readonly) NSTimeInterval animationDuration;

/*!
 * The background image to be displayed in the Glance widget. The \c groupBackgroundImage draws the text that
 * contains the number of remaining items to complete.
 */
@property (readonly) UIImage *groupBackgroundImage;

@end
