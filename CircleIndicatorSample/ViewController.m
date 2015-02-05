//
//  ViewController.m
//  CircleIndicatorSample
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
NSString *jsonData = @"{\"style\": \"GlanceStyle\",\"smallIcon\": \"default\",\"largeIcon\": \"default\",\"background\":\"bitmapName\",\"contentTitle\": \"Overall Title\",\"contentText\": \"This is the main text\",\"contentIntentName\": \"MainActivity\",\"RadialStyle\":{\"radialColor\":1,\"radialTotalItemCount\": 500,\"radialCompletedItemsCount\":222,\"radialHeaderLabelText\": \"Overall Budget\",\"radialInnerLabelText\": \"$222\",\"radialInnerSubLabelText\": \"Left\"},\"BigTextStyle\": {\"bigContentTitle\": \"Big content title\",\"bigText\":\"This is some very big text that might wrap and fill several lines I hope.\",\"summary\": \"Summary of big text.\"},\"pages\": [{\"pageTitle\":\"Page Title\",\"pageText\":\"New Page 1 Text.\"},{\"pageTitle\": \"Page 2 Title\",\"pageText\": \"New Page 2 Text.\"}],\"ListStyle\": {\"icon\":\"ic_menu_tt\",\"title\": \"Tap to take action!\",\"label\": \"Tax Day\",\"intentName\": \"com.intuit.intuitwear.testcases.ActionReceiver\",\"item\": [\"Purchase TurboTax\",\"Create Event\",\"Remind me later\",\"Dismiss\",\"Web Site\",\"Create a CalendarEvent\",\"Set an Alarm\",\"I don't pay taxes\"],\"visible\": 4}}";

/*!
 * @class ViewController
 *
 * @discussion Main iPhone application View Controller that handles all callbacks
 *             for the Circle Indicator controls (i.e. max, current values, etc).
 */
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
    
    if (notificationContent.radialStyle.radialInnerLabelText == nil) {
        NSString *completedCountValue = [NSString stringWithFormat:@"%ld", notificationContent.radialStyle.radialCompletedItemsCount];
        notificationContent.radialStyle.radialInnerLabelText = completedCountValue;
    }
    
    // Update User Defaults with the default values so the Glance has access to
    // this data
    [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    
        NSLog(@"JsonData to string %@", notificationContent.toJSONString);
    
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

/*!
 *  Callback method called after the View Controller appeared on the screen.
 *
 *  @param animated Flag indicating if view should be animated as it appears.
 */
- (void) viewDidAppear:(BOOL)animated {
    // Set Color Picker to notification content setting.
    // NOTE: This should be set here in viewDidAppear instead of viewDidLoad
    NSInteger selectedDefaultRowShouldBe = notificationContent.radialStyle.radialColor;
    [_glanceColorPicker selectRow:selectedDefaultRowShouldBe inComponent:0 animated:NO];
    [_glanceColorPicker reloadComponent:0];
}

/*!
 *  Callback invoked when a memory warning occurs.  Dispose of any
 *  resources that were created by this class.
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 *  Returns the number of 'columns' to display.
 *
 *  @param pickerView Color picker that allows the user to choose the color
 *                    of the Circle Indicator.
 *
 *  @return Returns the number of components in the Picker view.
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/*!
 *  Returns the # of rows in each component
 *
 *  @param pickerView Color picker that allows the user to choose the color
 *                    of the Circle Indicator.
 *  @param component  Integer representing the row Component
 *
 *  @return # of rows in each component
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _colorData.count;
}

/*!
 *  Returns the title of a given input row.
 *
 *  @param pickerView Color picker that allows the user to choose the color
 *                    of the Circle Indicator.
 *  @param row        Integer representing the row for which the title will be returned.
 *  @param component  Integer representing the component within the row.
 *
 *  @return The title of the Row.
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _colorData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"===> Row selected = %ld", (long)row);
    
    if ( notificationContent ) {
        notificationContent.radialStyle.radialColor = row;
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }
}

/*!
 *  Callback invoked when the total count slider value has changed.
 *
 *  @param sender The UISlider object causing the event to trigger.
 */
- (IBAction)totalCountValueChanged:(UISlider *)sender {
    self.totalCountValue.text = [NSString stringWithFormat:@"%f", sender.value];
    
    if (notificationContent) {
        // Save modified value to our IWearNotificationContent object
        notificationContent.radialStyle.radialTotalItemCount = sender.value;
        
        // Update the NSUserDefaults with the new value for the GlanceWidget
        NSLog(@"===> totalCount change in notification Content - %ld", (long)notificationContent.radialStyle.radialTotalItemCount);
        [IWAppConfiguration sharedAppConfiguration].iwContent = notificationContent;
    }
}

/*!
 *  Callback invoked when the completed count slider value has changed.
 *
 *  @param sender The UISlider object causing the event to trigger.
 */
- (IBAction)completedCountValueChanged:(UISlider *)sender {
    int intSliderValue = [sender value];
    self.completedCountValue.text = [NSString stringWithFormat:@"%i", intSliderValue];
    
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
