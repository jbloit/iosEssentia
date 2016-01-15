//
//  IOEssentia.h
//  Loudness
//
//  Created by julien@macmini on 1/14/16.
//  Copyright © 2016 onoffon. All rights reserved.
//

#ifndef IOEssentia_h
#define IOEssentia_h

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface IOEssentia : NSObject 
+ (instancetype) sharedInstance;
- (float) loudness:(AudioBufferList*) bufferList withSize:(int)lengthInFrames;

@end

#endif /* IOEssentia_h */
