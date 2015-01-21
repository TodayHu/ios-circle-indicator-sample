//
//  GlanceController.h
//  CircleIndicatorSample WatchKit Extension
//
//  Created by Osmon, Cindy on 1/20/15.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface GlanceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *glanceWidgetGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *glanceWidgetImage;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *upperGlanceGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *glanceHeaderLabel;

@end
