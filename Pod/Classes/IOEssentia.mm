//
//  IOEssentia.m
//  Loudness
//
//  Created by julien@macmini on 1/14/16.
//  Copyright © 2016 onoffon. All rights reserved.
//

#import "IOEssentia.h"

#include "essentia.h"
#include "algorithmfactory.h"


static IOEssentia *_sharedInstance = nil;

@implementation IOEssentia

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[IOEssentia alloc] init];
    });
    return _sharedInstance;
}

-(id)init {
    if (self = [super init])  {
        // so some inits here
    }
    return self;
}


- (float) loudness:(AudioBufferList*) bufferList withSize:(int)lengthInFrames{
    
//    float loudness = 666.f;
    
    essentia::Real loudness;
    
    essentia::init();
    essentia::standard::AlgorithmFactory& factory = essentia::standard::AlgorithmFactory::instance();
    essentia::standard::Algorithm* vickersLoudness = factory.create("LoudnessVickers");
    
    std::vector<essentia::Real> audio;
    
    for(int i=0; i< lengthInFrames; i++) {
        SInt16 sintSample = ((SInt16*)bufferList->mBuffers[0].mData)[i];
        float floatSample = sintSample / (float)SHRT_MAX;
        audio.push_back(floatSample);
    }
    
    vickersLoudness->input("signal").set(audio);
    vickersLoudness->output("loudness").set(loudness);
    vickersLoudness->compute();
    
    return (float)loudness;
}

@end