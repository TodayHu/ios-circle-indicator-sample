//
//  IWAppConfiguration.h
//  IWApp
//
//  Created by Osmon, Cindy on 12/31/14.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <Foundation/Foundation.h>
#import <IntuitWearKit/IWearNotificationContent.h>

/*!
 *  @discussion Enumeration of possible colors of the Circle Indicator
 */
typedef NS_ENUM(NSInteger, IWGlanceColor){
    /*!
     *  @discussion Red color
     */
    IWGlanceColorRed,
    /*!
     *  @discussion Green color
     */
    IWGlanceColorGreen,
    /*!
     *  @discussion Yellow color
     */
    IWGlanceColorYellow,
    /*!
     *  @discussion Default color is Green
     */
    IWGlanceColorDefault
};

/*!
 *  External constant that should be used to indicate the App Group name
 */
extern NSString *const IWAppConfigurationApplicationGroupsPrimary;

/*!
 *  External constant representing the Key to storing and retrieving
 *  the IWearNotificationContent object shared betwen the iPhone app
 *  and the Watch App
 */
extern NSString *const IWAppConfigurationIWContentUserDefaultsKey;

/*!
 * @class IWAppConfiguration
 *
 * @discussion This class is a helper class for application configuration. 
 *             It can be used to ease access to storing and retrieving data
 *             from NSUserDefaults.
 */
@interface IWAppConfiguration : NSObject

/*!
 * @discussion Object representing all of the fields from the notification json.
 *             This data can be used to create many kinds of notifications.
 */
@property (nonatomic) IWearNotificationContent *iwContent;

/*!
 * @discussion GlanceStyle contains all of the data necessary to create and draw
 *             the IWGlanceCircleIndicator widget.
 */
@property (nonatomic) GlanceStyle *iwGlanceStyle;

/*!
 * @discussion Getter method that returns static accessor for the sharedAppConfiguration.
 *
 * @return Returns static accessor for the sharedAppConfiguration
 */
+ (IWAppConfiguration *)sharedAppConfiguration;

/*!
 *  @discussion This method converts the integer color value into its string representation.
 *
 *  @param color Integer value representing the color as defined by the IWGlanceColor
 *               Enumeration. Red = 0, Green = 1, Yellow = 2
 *
 *  @return String value of the color (i.e. "Red", "Green", "Yellow"
 */
+ (NSString *)glanceColorStringFromInteger:(NSInteger)color;

@end
