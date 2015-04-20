//
//  ViewController.m
//  IWApp
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

@import IntuitWearKit;


#import "ViewController.h"
#import <IntuitWearKit/MMWormhole.h>


@interface ViewController ()
@property (nonatomic, strong) MMWormhole *wormhole;

@end


NSArray *_colorData;
IWearNotificationContent *notificationContent;

// Define default data for Glance
NSString *jsonData = @"{\"style\": \"GlanceStyle\",\"smallIcon\": \"default\",\"largeIcon\": \"default\",\"background\":\"bitmapName\",\"contentTitle\": \"Overall Title\",\"contentText\": \"This is the main text\",\"contentIntentName\": \"MainActivity\",\"RadialStyle\":{\"radialColor\":\"radialImageGreen-\",\"radialTotalItemCount\": 500,\"radialCompletedItemsCount\":222,\"radialHeaderLabelText\": \"Overall Budget\",\"radialInnerLabelText\": \"$222\",\"radialInnerSubLabelText\": \"Left\"},\"BigTextStyle\": {\"bigContentTitle\": \"Big content title\",\"bigText\":\"This is some very big text that might wrap and fill several lines I hope.\",\"summary\": \"Summary of big text.\"},\"pages\": [{\"pageTitle\":\"Page Title\",\"pageText\":\"New Page 1 Text.\",\"pageBackground\":\"background1_img\"},{\"pageTitle\": \"Page 2 Title\",\"pageText\": \"New Page 2 Text.\",\"pageBackground\":\"background2_img\"}], \"actions\": [{\"icon\": \"icon_name_1\",\"actionName\": \"Button 1\",\"intentName\": \"com.intuit.intuitwear.MainActivity\"},{\"icon\": \"icon_name_2\",\"actionName\": \"Button 2\",\"intentName\": \"com.intuit.intuitwear.MainActivity\"}],\"ListStyle\": {\"icon\":\"ic_menu_tt\",\"title\": \"Tap to take action!\",\"label\": \"Tax Day\",\"intentName\": \"com.intuit.intuitwear.testcases.ActionReceiver\",\"item\": [\"Purchase TurboTax\",\"Create Event\",\"Remind me later\",\"Dismiss\",\"Web Site\",\"Create a CalendarEvent\",\"Set an Alarm\",\"I don't pay taxes\"],\"visible\": 4}}";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the Global Apps Group variable first thing!
    IWAppConfigurationApplicationGroupsPrimary = @"group."INTUITWEAR_BUNDLE_PREFIX_STRING@".IWApp.storage";
    
    NSLog(@"%@ ===> viewDidLoad called!", self);
    NSLog(@"===> JSON String initialized as: %@",jsonData);
    
    // Initialize the wormhole
    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.com.intuit.intuitwear.IWApp.storage" optionalDirectory:@"local"];
    
    // Set color data for glanceColorPicker
    _colorData = @[@"Red", @"Green"];
    
    // Connect the data to the color Picker
    self.glanceColorPicker.dataSource = self;
    self.glanceColorPicker.delegate = self;
    
    // Create IWearNotificationContent object from json data.
    notificationContent = [[IWearNotificationContent alloc] initWithString:jsonData error:nil];
    
    // Just testing Using Pages array
    NSArray *pages = notificationContent.pages;
    if (pages != nil) {
        for (Page *object in pages) {
            NSLog(@"page Title: %@", object.pageTitle);
            NSLog(@"page background %@", object.pageBackground);
        }
    }
    
    // Just testing Using Actions array
    NSArray *actions = notificationContent.actions;
    if (actions != nil) {
        for (Action *object in actions) {
            NSLog(@"action icon: %@", object.icon);
            NSLog(@"action Name %@", object.actionName);
            NSLog(@"action IntentName %@", object.intentName);
            
        }
    }
    
    // If glanceInnerLabel is nil, set it to the completed items count.  This lets the
    // user set the Inner Label based on the value of the completed items count instead
    // of having to set both values.
    
    if (notificationContent.radialStyle.radialInnerLabelText == nil) {
        NSString *completedCountValue = [NSString stringWithFormat:@"%ld", notificationContent.radialStyle.radialCompletedItemsCount];
        notificationContent.radialStyle.radialInnerLabelText = completedCountValue;
    }
    
    // Update User Defaults with the default values so the Glance has access to
    // this data
    [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    
    //    NSLog(@"JsonData to string %@", notificationContent.toJSONString);
    
    /////////////////////////////////////////////////////////////////////////
    //
    // Init UI with Default JSON data
    
    // Init Total Count Slider values
    self.totalCountValue.text = [NSString stringWithFormat:@"%ld", (long)notificationContent.radialStyle.radialTotalItemCount];
    self.glanceTotalSlider.value = notificationContent.radialStyle.radialTotalItemCount;
    
    // Init Completed Count Slider values
    self.completedCountValue.text = [NSString stringWithFormat:@"%ld", (long)notificationContent.radialStyle.radialCompletedItemsCount];
    self.glanceCompletedSlider.value = notificationContent.radialStyle.radialCompletedItemsCount;
}

- (void) viewDidAppear:(BOOL)animated {
    // Set Color Picker to notification content setting.
    // NOTE: This should be set in viewDidAppear instead of viewDidLoad
    
    // Get image from stored value if it exists and set row based on this value
    NSString * currentImgName = nil;
    NSInteger currentRow = 0;
    if (notificationContent) {
        currentImgName = notificationContent.radialStyle.radialColor;
        if ( [currentImgName isEqualToString:@"radialImageGreen-"]) {
            currentRow = 1;
        }
    }
    
    NSInteger selectedDefaultRowShouldBe = currentRow;
    [_glanceColorPicker selectRow:selectedDefaultRowShouldBe inComponent:0 animated:NO];
    [_glanceColorPicker reloadComponent:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _colorData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _colorData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"===> Row selected = %ld", (long)row);
    
    if ( notificationContent ) {
        if (row == 0) {
            notificationContent.radialStyle.radialColor = @"radialImageGreen-";
        } else {
            notificationContent.radialStyle.radialColor = @"radialImageRed-";
        }
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }
}

- (IBAction)totalCountValueChanged:(UISlider *)sender {
    self.totalCountValue.text = [NSString stringWithFormat:@"%f", sender.value];
    
    // Pass value through wormhole to Watch Glance.
    // This updates the Watch Glance in realtime as the iOS app changes values.
    [self.wormhole passMessageObject:@{@"totalCount" : [NSNumber numberWithFloat: sender.value]} identifier:@"RadialTotalCount"];
    
    if (notificationContent) {
        // Save modified value to our IWearNotificationContent object
        notificationContent.radialStyle.radialTotalItemCount = sender.value;
        
        // Update the NSUserDefaults with the new value for the GlanceWidget
        NSLog(@"===> totalCount change in notification Content - %ld", (long)notificationContent.radialStyle.radialTotalItemCount);
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
        
    }
}

- (IBAction)completedCountValueChanged:(UISlider *)sender {
    int intSliderValue = [sender value];
    self.completedCountValue.text = [NSString stringWithFormat:@"%i", intSliderValue];
    
    // Pass value through wormhole to Watch Glance
    [self.wormhole passMessageObject:@{@"completedCount" : [NSNumber numberWithInteger:intSliderValue]} identifier:@"RadialCompletedCount"];
    
    // Save new value to NSUserDefaults
    if (notificationContent) {
        notificationContent.radialStyle.radialCompletedItemsCount = sender.value;
        
        // Build inner label text.  If it wasn't initialized, set it to the completed
        //items value.
        
        NSString *innerText = notificationContent.radialStyle.radialInnerLabelText;
        
        if ( innerText == nil ) {
            notificationContent.radialStyle.radialInnerLabelText = self.completedCountValue.text;
        }
        
        // Update the NSUserDefaults with the new value for the GlanceWidget
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }
    
}

@end
