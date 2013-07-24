//
//  Contents.h
//
//  This model was created on 2013-07-23 by LaneKit v0.1.6.
//
// The following LaneKit command was used to generate this model:
// lanekit generate model Contents contents:array:Video
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface Contents : NSObject

@property (nonatomic,strong) NSArray *contents;  // relates to: Video

+ (RKObjectMapping *)requestMapping;
+ (RKObjectMapping *)responseMapping;

@end
