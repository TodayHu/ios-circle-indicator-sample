//
//  GlanceStyle.h
//  IWApp
//
//  Created by Osmon, Cindy on 1/2/15.
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
#import <Foundation/Foundation.h>
#import <IntuitWearKit/JSONModel.h>

/*!
 * @class GlanceStyle
 *
 * @discussion Notification Style that represents a radial graph much like the Apple 
 *             Watch Activity App.
 */
@interface GlanceStyle : JSONModel  <NSCoding> 

/*!
 * @discussion Integer representing the color of the circle to draw. 
 *             Current values are 0 = Red, 1 = Green
 */

@property (nonatomic) NSInteger glanceColor;

/*!
 * @discussion Header text that will be drawn in the Group above the Circle.
 */
@property (nonatomic, retain) NSString<Optional>* glanceHeaderLabelText;

/*!
 * @discussion First line of text that is drawn in the center of the Circle.
 */
@property (nonatomic, retain) NSString<Optional>* glanceInnerLabelText;

/*!
 * @discussion Second line of sub text that is drawn in the center of the Circle.
 */
@property (nonatomic, retain) NSString<Optional>* glanceInnerSubLabelText;

/*!
 * @discussion Total number of segments in the circle (i.e. Total number of images).
 */
@property (nonatomic) NSInteger glanceTotalItemCount;

/*!
 * @discussion Number of completed items which will determine the number of images
 *             drawn.
 */
@property (nonatomic) NSInteger glanceCompletedItemsCount;

@end
