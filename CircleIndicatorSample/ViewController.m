//
//  ViewController.m
//  CircleIndicatorSample
//
//  Created by Osmon, Cindy on 1/20/15.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
// The MIT License (MIT)
//
//Copyright (c) <year> <copyright holders>
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

#import "ViewController.h"

@import IntuitWearKit;

@interface ViewController ()
- (IBAction)totalCountValueChanged:(id)sender;
- (IBAction)completedCountValueChanged:(id)sender;

@end

/*!
 * @discussion Initial values for Color Picker.
 */
NSArray *_colorData;

/*!
 * @discussion Object representing the JSON payload content for our Apple Watch App
 */
IWearNotificationContent *notificationContent;

/*!
 * @discussion Initialize default data for Glance Content
 */
NSString *jsonData = @"{\"style\": \"GlanceStyle\",\"smallIcon\": \"default\",\"largeIcon\": \"default\",\"background\":\"bitmapName\",\"contentTitle\": \"Overall Title\",\"contentText\": \"This is the main text\",\"contentIntentName\": \"MainActivity\",\"glanceStyle\":{\"glanceColor\":1,\"glanceTotalItemCount\": 500,\"glanceCompletedItemsCount\":222,\"glanceHeaderLabelText\": \"Overall Budget\",\"glanceInnerLabelText\": \"$222\",\"glanceInnerSubLabelText\": \"Left\"},\"BigTextStyle\": {\"bigContentTitle\": \"Big content title\",\"bigText\":\"This is some very big text that might wrap and fill several lines I hope.\",\"summary\": \"Summary of big text.\"},\"pages\": [{\"pageTitle\":\"Page Title\",\"pageText\":\"New Page 1 Text.\"},{\"pageTitle\": \"Page 2 Title\",\"pageText\": \"New Page 2 Text.\"}],\"ListStyle\": {\"icon\":\"ic_menu_tt\",\"title\": \"Tap to take action!\",\"label\": \"Tax Day\",\"intentName\": \"com.intuit.intuitwear.testcases.ActionReceiver\",\"item\": [\"Purchase TurboTax\",\"Create Event\",\"Remind me later\",\"Dismiss\",\"Web Site\",\"Create a CalendarEvent\",\"Set an Alarm\",\"I don't pay taxes\"],\"visible\": 4}}";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ////////////////////////////////////////////////////////////////////////
    // Set the Global Apps Group variable first thing!
    // This is used to define the App Groups string that defines the
    // storage area between the iPhone app and the Watch App.
    IWAppConfigurationApplicationGroupsPrimary = @"group."INTUITWEAR_BUNDLE_PREFIX_STRING@".IWApp.storage";
    
    // Set color data for glanceColorPicker
    _colorData = @[@"Red", @"Green"];
    
    // Connect the data to the color Picker
    self.glanceColorPicker.dataSource = self;
    self.glanceColorPicker.delegate = self;
    
    // User IntuitWearKit SKD t create IWearNotificationContent object from json data.
    notificationContent = [[IWearNotificationContent alloc] initWithString:jsonData error:nil];
    
    // If glanceInnerLabel is nil, set it to the completed items count.  This lets the
    // user set the Inner Label based on the value of the completed items count instead
    // of having to set both values.
    
    if (notificationContent.glanceStyle.glanceInnerLabelText == nil) {
        NSString *completedCountValue = [NSString stringWithFormat:@"%ld", notificationContent.glanceStyle.glanceCompletedItemsCount];
        notificationContent.glanceStyle.glanceInnerLabelText = completedCountValue;
    }
    
    // Update User Defaults with the default values so the Glance has access to
    // this data
    [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    
        NSLog(@"JsonData to string %@", notificationContent.toJSONString);
    
    /////////////////////////////////////////////////////////////////////////
    //
    // Init UI with Default JSON data
    
    // Init Total Count Slider values
    self.totalCountValue.text = [NSString stringWithFormat:@"%ld", (long)notificationContent.glanceStyle.glanceTotalItemCount];
    self.glanceTotalSlider.value = notificationContent.glanceStyle.glanceTotalItemCount;
    
    // Init Completed Count Slider values
    self.completedCountValue.text = [NSString stringWithFormat:@"%ld", (long)notificationContent.glanceStyle.glanceCompletedItemsCount];
    self.glanceCompletedSlider.value = notificationContent.glanceStyle.glanceCompletedItemsCount;
}

- (void) viewDidAppear:(BOOL)animated {
    // Set Color Picker to notification content setting.
    // NOTE: This should be set in viewDidAppear instead of viewDidLoad
    NSInteger selectedDefaultRowShouldBe = notificationContent.glanceStyle.glanceColor;
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
        notificationContent.glanceStyle.glanceColor = row;
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }
}

- (IBAction)totalCountValueChanged:(UISlider *)sender {
    self.totalCountValue.text = [NSString stringWithFormat:@"%f", sender.value];
    
    if (notificationContent) {
        // Save modified value to our IWearNotificationContent object
        notificationContent.glanceStyle.glanceTotalItemCount = sender.value;
        
        // Update the NSUserDefaults with the new value for the GlanceWidget
        NSLog(@"===> totalCount change in notification Content - %ld", (long)notificationContent.glanceStyle.glanceTotalItemCount);
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }
}

- (IBAction)completedCountValueChanged:(UISlider *)sender {
    int intSliderValue = [sender value];
    self.completedCountValue.text = [NSString stringWithFormat:@"%i", intSliderValue];
    
    // Save new value to NSUserDefaults
    if (notificationContent) {
        notificationContent.glanceStyle.glanceCompletedItemsCount = sender.value;
        
        // Build inner label text.  If it wasn't initialized, set it to the completed
        //items value.
        
        NSString *innerText = notificationContent.glanceStyle.glanceInnerLabelText;
        
        if ( innerText == nil ) {
            notificationContent.glanceStyle.glanceInnerLabelText = self.completedCountValue.text;
        }
        
        // Update the NSUserDefaults with the new value for the GlanceWidget
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }

}
@end
