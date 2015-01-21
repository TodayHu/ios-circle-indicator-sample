//
//  NSUserDefaults+NSUserDefaultsExtentions.h
//  IWApp
//
//  Created by Osmon, Cindy on 1/4/15.
//
//  Copyright (c) 1/2/15 Intuit Inc. All rights reserved. Unauthorized reproduction is a
//  violation of applicable law. This material contains certain confidential and proprietary
//  information and trade secrets of Intuit Inc.
//
#import <Foundation/Foundation.h>

/*!
 * @category NSUserDefaultsExtensions
 *
 * @discussion This category adds the ability to save Custom created objects to NSUserDefaults
 */
@interface NSUserDefaults (NSUserDefaultsExtensions)

/*!
 *  @discussion This method can be used to save a custom object to NSUserDefaults.
 *
 *  @param object The custom object to be saved.  Note: it must implement the NSCoding Protocol.
 *  @param key    The NSUserDefaults key to be used to store and retrieve the object.
 */
- (void)saveCustomObject:(id<NSCoding>)object
                     key:(NSString *)key;

/*!
 * @discussion This method can be used to retrieve a custom object from NSUserDefaults.
 *
 * @param key The NSUserDefaults key to be used to store and retrieve the object.
 * @return Returns the Custom Object for the given key.
 */
- (id<NSCoding>)loadCustomObjectWithKey:(NSString *)key;

@end
