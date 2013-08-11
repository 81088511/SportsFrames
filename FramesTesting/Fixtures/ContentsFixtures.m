//
//  ContentsFixtures.m
//
//  This model fixture was created on 2013-08-11 by LaneKit v0.2.0.
//

#import "ContentsFixtures.h"
#import "VideoFixtures.h"

@implementation ContentsFixtures

+ (Contents *)one
{
  Contents *contents = Contents.new;

  contents.contents = @[VideoFixtures.one];

  return contents;
}

+ (Contents *)two
{
  Contents *contents = Contents.new;

  contents.contents = @[VideoFixtures.one, VideoFixtures.two];

  return contents;
}

@end