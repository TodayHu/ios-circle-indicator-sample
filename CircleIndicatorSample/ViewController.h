//
//  ViewController.h
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

#import <UIKit/UIKit.h>

/*!
 * @class ViewController
 *
 * @discussion Main iPhone application View Controller that handles all callbacks
 *             for the Circle Indicator controls (i.e. max, current values, etc).
 */
@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

/*!
 * @discussion UIPicker that lets you set the color of the Circle Indicator
 */
@property (weak, nonatomic) IBOutlet UIPickerView *glanceColorPicker;

/*!
 * @discussion Slider to control the total number of segments in the Circle Indicator
 */
@property (weak, nonatomic) IBOutlet UISlider *glanceTotalSlider;

/*!
 * @discussion Slider to control how many items of the Circle Indicator are complete
 */
@property (weak, nonatomic) IBOutlet UISlider *glanceCompletedSlider;

/*!
 * @discussion Label representing the value selected from the glanceTotalSlider
 */
@property (weak, nonatomic) IBOutlet UILabel *totalCountValue;

/*!
 * @discussion Label representing the value selected from the glanceCompletedSlider
 */
@property (weak, nonatomic) IBOutlet UILabel *completedCountValue;

@end

