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
@end

@implementation GlanceController

#pragma mark - Initializers

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    
    ////////////////////////////////////////////////////////////////////////
    // Set the Global Apps Group variable first thing!
    // This is used to define the App Groups string that defines the
    // storage area between the iPhone app and the Watch App.
    IWAppConfigurationApplicationGroupsPrimary = @"group."INTUITWEAR_BUNDLE_PREFIX_STRING@".IWApp.storage";
    
    if (self){
        // Initialize variables here.
        GlanceStyle *glanceStyle = [self glanceStyleData];

        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        // Set the data fields for the Circle Indicator from the
        // GlanceStyle object obtained from NSUserDefaults data that
        // is shared between the iOS Phone App and the Glance.
        _presentedTotalListItemCount = glanceStyle.glanceTotalItemCount;
        
        _presentedCompleteListItemCount = glanceStyle.glanceCompletedItemsCount;
        
        [_glanceHeaderLabel setText:glanceStyle.glanceHeaderLabelText];
        
        NSLog(@"Watch Kit Extention for Glance : totalItemCount = %ld", _presentedTotalListItemCount);
        
        NSLog(@"Watch Kit Extention for Glance : completed ItemCount = %ld", _presentedCompleteListItemCount);
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    
    [self drawGlanceWidget:[self glanceStyleData]];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

/*!
 * @discussion Draws the Circle Indicator animation based on the data from
 *             the input GlanceStyle object.
 *
 * @param glancestyle The GlanceStyle object used to share data from the iOS Phone app and the Glance.
 * @return void
 */
- (void) drawGlanceWidget:(GlanceStyle *)glanceStyle {
    
    //Construct and draw the updated widget
    IWGlanceCircleIndicator *glanceWidget = [[IWGlanceCircleIndicator alloc] initWithGlanceStyle:glanceStyle];
    [self.glanceWidgetGroup setBackgroundImage:glanceWidget.groupBackgroundImage];
    [self.glanceWidgetImage setImageNamed:glanceWidget.imageName];
    NSRange imageRange = glanceWidget.imageRange;
    NSLog(@"my range is %@", NSStringFromRange(imageRange));
    [self.glanceWidgetImage startAnimatingWithImagesInRange:glanceWidget.imageRange duration:glanceWidget.animationDuration repeatCount:1];
}

/*!
 * @discussion Draws the Circle Indicator animation based the total item count and
 *             the number of completed items
 * @param totalItemCount The total item count of the Circle Indicator
 * @param numberComplete Number of completed items out of the total.
 * @return void
 */
- (void) drawGlanceWidget:(NSInteger)totalItemCount withNumberCompleted:(NSInteger)numberComplete {
    
    //Construct and draw the updated widget
    IWGlanceCircleIndicator *glanceWidget = [[IWGlanceCircleIndicator alloc] initWithTotalItemCountAndColor:totalItemCount completeItemCount:numberComplete color:0];
    
    [self.glanceWidgetGroup setBackgroundImage:glanceWidget.groupBackgroundImage];
    [self.glanceWidgetImage setImageNamed:glanceWidget.imageName];
    [self.glanceWidgetImage startAnimatingWithImagesInRange:glanceWidget.imageRange duration:glanceWidget.animationDuration repeatCount:1];
}

/*!
 * @discussion This method retrieves the GlanceStyle object from NSUserDefaults so it
 *             can share data between the iOS Phone App and the Glance.
 *
 * @return The GlanceStyle object from NSUserDefaults.
 */
- (GlanceStyle *)glanceStyleData {
    NSUserDefaults *userDefault=[[NSUserDefaults alloc] initWithSuiteName:IWAppConfigurationApplicationGroupsPrimary];
    NSData *myDecodedObject = [userDefault objectForKey: IWAppConfigurationIWContentUserDefaultsKey];
    IWearNotificationContent *glanceContent = [NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
    return glanceContent.glanceStyle;
}

@end



