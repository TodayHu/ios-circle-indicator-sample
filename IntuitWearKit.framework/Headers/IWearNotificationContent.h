//
//  IWearNotificationContent.h
//  IntuitWear
//
//  Created by Osmon, Cindy on 12/21/14.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <Foundation/Foundation.h>
#import <IntuitWearKit/JSONModel.h>
#import <IntuitWearKit/ListStyle.h>
#import <IntuitWearKit/IWGlanceCircleIndicator.h>
#import <IntuitWearKit/Page.h>
#import <IntuitWearKit/WearableAction.h>
#import <IntuitWearKit/Action.h>

@class GlanceStyle;
@class ListStyle;

/*!
 * @class IWearNotificationContent
 *
 * @description This class represents the object encapsulation of the Intuit Wear
 *  JSON schema for transferring data to wearable devices.
 */
@interface IWearNotificationContent : JSONModel  <NSCoding>

/*!
 *  The style of the notification to be delivered.
 *  Possible values are:
 *      BigTextStyle
 *      InboxStyle
 *      ListStyle
 *      GlanceStyle
 */
@property (nonatomic, retain) NSString *style;

/*!
 *  Small icon to use in the notification layouts, can be resource Id or a URL
 *  on Android but must be the name of the icon on iOS.
 */
@property (nonatomic, retain) NSString<Optional> *smallIcon;

/*!
 *  Large icon to use in the notification layouts, can be resource Id or a URL
 *  on Android but must be the name of the icon on iOS.
 */
@property (nonatomic, retain) NSString<Optional> *largeIcon;

/*!
 *  Name of Background image
 */
@property (nonatomic, retain) NSString<Optional> *background;

/*!
 *  Title for the notification.
 */
@property (nonatomic, retain) NSString<Optional> *contentTitle;

/*!
 *  Body text of the notification if different then the assert text
 */
@property (nonatomic, retain) NSString<Optional> *contentText;

/*!
 *  Name of a view controller to launch when an action button is clicked
 *  or the Glance is selected.
 */
@property (nonatomic, retain) NSString<Optional> *contentIntentName;

/*!
 *  This style supports a vertically scrolling item list
 */
@property (nonatomic, retain) ListStyle<Optional> *listStyle;

/*!
 *  This style supports a radial progress chart as is used in the Apple Watch Activity App
 */
@property (nonatomic, retain) GlanceStyle<Optional> *glanceStyle;

/*!
 *  Actions that can be triggered by this Notification
 */
@property (nonatomic, retain) NSArray<Action, Optional> *actions;

/*!
 *  Actions that can will only be available on a wearable device, not on the handheld/phone
 */
@property (nonatomic, retain) NSArray<WearableAction, Optional> *wearableActions;

/*!
 *  Page declaration for multi-page notifications
 */
@property (nonatomic, retain) NSArray<Page, Optional> *pages;




@end
