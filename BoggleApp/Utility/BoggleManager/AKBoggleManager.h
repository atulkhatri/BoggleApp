//
//  AKBoggleManager.h
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKBoggleManager : NSObject
+ (instancetype)sharedInstance;
- (NSArray*)findWordsInBoard:(NSArray*)board ofDimension:(NSInteger)dimension withDictionary:(NSArray*)dictionary;
@end
