//
//  ViewController.h
//  CircleIndicatorSample
//
//  Created by Osmon, Cindy on 1/20/15.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <UIKit/UIKit.h>

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

