//
//  GlanceController.m
//  CircleIndicatorSample WatchKit Extension
//
// Copyright (c) 2015 Intuit Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GlanceController.h"
@import IntuitWearKit;

#import <IntuitWearKit/MMWormhole.h>

/*!
 * @class GlanceController
 *
 * @discussion This class is the View Controller for an Apple Watch Glance.
 *             It controls drawing the Circle Indicator based on the total
 *             item count and the number of completed items.
 */
@interface GlanceController()
/*!
 *  @discussion These properties track the underlying values that represent the Circle Indicator.
 */
@property (nonatomic) NSInteger presentedTotalListItemCount;
@property (nonatomic) NSInteger presentedCompleteListItemCount;
@property (nonatomic, strong) MMWormhole *wormhole;
@property (nonatomic, strong) RadialStyle *radialStyle;
@end

@implementation GlanceController

#pragma mark - Initializers

- (void)awakeWithContext:(id)context {
    
    ////////////////////////////////////////////////////////////////////////
    // Set the Global Apps Group variable first thing!
    // This is used to define the App Groups string that defines the
    // storage area between the iPhone app and the Watch App.
    IWAppConfigurationApplicationGroupsPrimary = @"group."INTUITWEAR_BUNDLE_PREFIX_STRING@".IWApp.storage";
    
    if (self){
        
        // Initialize variables here.
        
        // Check if App Groups global variable has been set from main app.
        // Set it if it has not been previously set.  Must do this before
        // we get any data from NSUserDefaults
        if (IWAppConfigurationApplicationGroupsPrimary == nil || IWAppConfigurationApplicationGroupsPrimary.length == 0) {
            IWAppConfigurationApplicationGroupsPrimary = @"group."INTUITWEAR_BUNDLE_PREFIX_STRING@".IWApp.storage";
        }
        
        // Initialize communication channel with main iOS App
        self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.com.intuit.intuitwear.IWApp.storage" optionalDirectory:@"local"];
        
        
        _radialStyle = [self glanceStyleData];
        
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        _presentedTotalListItemCount = _radialStyle.radialTotalItemCount;
        
        _presentedCompleteListItemCount = _radialStyle.radialCompletedItemsCount;
        
        [_glanceHeaderLabel setText: _radialStyle.radialHeaderLabelText];
        
        // Listen for changes to the selection message. The selection message contains a string value
        // identified by the selectionString key. Note that the type of the key is included in the
        // name of the key.
        [self.wormhole listenForMessageWithIdentifier:@"RadialTotalCount" listener:^(id messageObject) {
            NSNumber *total = [messageObject valueForKey:@"totalCount"];
            _presentedTotalListItemCount = [total integerValue];
            _radialStyle.radialTotalItemCount =_presentedTotalListItemCount;
            
            // Recompute Inner label representing # items left
            NSInteger newLabelVal = _presentedTotalListItemCount - _radialStyle.radialCompletedItemsCount;
            _radialStyle.radialInnerLabelText = [NSString stringWithFormat:@"%ld", newLabelVal];
            
            // redraw watch UI
            [self drawGlanceWidget:_radialStyle];
        }];
        
        [self.wormhole listenForMessageWithIdentifier:@"RadialCompletedCount" listener:^(id messageObject) {
            NSNumber *completed = [messageObject valueForKey:@"completedCount"];
            _presentedCompleteListItemCount = [completed integerValue];
            _radialStyle.radialCompletedItemsCount =_presentedCompleteListItemCount;
            
            // Recompute Inner label representing # items left
            NSInteger newLabelVal = _radialStyle.radialTotalItemCount - _presentedCompleteListItemCount;
            _radialStyle.radialInnerLabelText = [NSString stringWithFormat:@"%ld", newLabelVal];
            
            // redraw watch UI
            [self drawGlanceWidget:_radialStyle];
        }];
        
        NSLog(@"Watch Kit Extention for Glance : totalItemCount = %ld", _presentedTotalListItemCount);
        
        NSLog(@"Watch Kit Extention for Glance : completed ItemCount = %ld", _presentedCompleteListItemCount);
    }
}

- (void) drawGlanceWidget:(RadialStyle *)radialStyle {
    
    //Construct and draw the updated widget
    IWRadialIndicator *glanceWidget = [[IWRadialIndicator alloc] initWithRadialStyle:radialStyle];
    glanceWidget.numberOfImages = 360;
    
    [self.glanceWidgetGroup setBackgroundImage:glanceWidget.groupBackgroundImage];
    [self.glanceWidgetImage setImageNamed:glanceWidget.radialColor];
    NSRange imageRange = glanceWidget.imageRange;
    NSLog(@"my range is %@", NSStringFromRange(imageRange));
    [self.glanceWidgetImage startAnimatingWithImagesInRange:glanceWidget.imageRange duration:glanceWidget.animationDuration repeatCount:1];
}

- (void) drawGlanceWidget:(NSInteger)totalItemCount withNumberCompleted:(NSInteger)numberComplete {
    
    //Construct and draw the updated widget
    IWRadialIndicator *glanceWidget = [[IWRadialIndicator alloc] initWithTotalItemCountAndColor:totalItemCount completeItemCount:numberComplete color:@"radialImageRed-"];
    
    [self.glanceWidgetGroup setBackgroundImage:glanceWidget.groupBackgroundImage];
    [self.glanceWidgetImage setImageNamed:glanceWidget.radialColor];
    [self.glanceWidgetImage startAnimatingWithImagesInRange:glanceWidget.imageRange duration:glanceWidget.animationDuration repeatCount:1];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    
    //    _radialStyle = [self glanceStyleData];
    [self drawGlanceWidget:_radialStyle];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (RadialStyle *)glanceStyleData {
    NSUserDefaults *userDefault=[[NSUserDefaults alloc] initWithSuiteName:IWAppConfigurationApplicationGroupsPrimary];
    NSData *myDecodedObject = [userDefault objectForKey: IWAppConfigurationIWContentUserDefaultsKey];
    IWearNotificationContent *glanceContent = [NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    return glanceContent.radialStyle;
}

@end



