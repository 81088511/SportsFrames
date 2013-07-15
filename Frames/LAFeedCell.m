/*
 The MIT License
 
 Copyright (c) 2013 Larry Aasen
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "LAFeedCell.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAGradientLayer.h>

static CGFloat cellHeight = 178;

static CGFloat contentMarginTop = 5;
static CGFloat contentMarginRight = 5;
static CGFloat contentMarginBottom = 5;
static CGFloat contentMarginLeft = 5;

static CGFloat textMarginRight = 15;
static CGFloat textMarginBottom = 10;
static CGFloat textMarginLeft = 15;

@interface LAFeedCell ()
{
  CAGradientLayer *gradientLayer;
  UIView *overlayContainer;
}

-(void)addOverlayToView1:(UIView *)view;
-(void)addOverlayToView2:(UIView *)view;

@end

@implementation LAFeedCell

+ (CGFloat)cellHeight
{
  return cellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
      self.imageView.contentMode = UIViewContentModeScaleAspectFit;

      self.textLabel.backgroundColor = [UIColor clearColor];
      self.textLabel.textColor = [UIColor whiteColor];
      self.textLabel.font = [UIFont boldSystemFontOfSize:14];
      self.textLabel.numberOfLines = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)makeTopSubview:(UIView *)view
{
  UIView *superview = [view superview];
  [view removeFromSuperview];
  [superview addSubview:view];
}

- (void)makeTopSubview
{
  [self makeTopSubview:self];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGRect bounds = [self bounds];
  bounds.origin.x = contentMarginLeft;
  bounds.origin.y = contentMarginTop;
  bounds.size.width  -= contentMarginRight + contentMarginLeft;
  bounds.size.height -= contentMarginTop + contentMarginBottom;
  [self.contentView setFrame:bounds];

  if (self.imageView)
  {
    CGRect imageFrame = self.imageView.frame;
    imageFrame.size = bounds.size;
    imageFrame.size.width -= 10;
    imageFrame.origin.x = (bounds.size.width - imageFrame.size.width) / 2.0;
    imageFrame.origin.y = 0;
    self.imageView.frame = CGRectIntegral(imageFrame);
    
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds= YES;
    
    [self addOverlayToView1:self.imageView];
  }
  
  CGRect textFrame = self.textLabel.frame;
  textFrame.size.width  = bounds.size.width - (textMarginRight + textMarginLeft);
  textFrame.size.height = 100;
  textFrame.origin.x = textMarginRight;
  self.textLabel.frame = textFrame;
  [self.textLabel sizeToFit];

  textFrame = self.textLabel.frame;
  textFrame.origin.y = bounds.size.height - textFrame.size.height - textMarginBottom;
  self.textLabel.frame = textFrame;

  [self makeTopSubview:self.textLabel];
}

-(void)addOverlayToView1:(UIView *)view
{
  if (!gradientLayer)
  {
    gradientLayer = [CAGradientLayer layer];
    [view.layer addSublayer:gradientLayer];
  }
  
  CGRect frame = view.bounds;
  frame.size.height = frame.size.height / 2;
  frame.origin.y = frame.size.height;
  gradientLayer.frame = CGRectIntegral(frame);
  
  gradientLayer.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithWhite:1.0f alpha:0.0f].CGColor,
                          (id)[UIColor colorWithWhite:0.0f alpha:0.3f].CGColor,
                          (id)[UIColor colorWithWhite:0.0f alpha:0.7f].CGColor,
                          nil];

//    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
//    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
  gradientLayer.locations = @[[NSNumber numberWithFloat:0.25f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:0.7f]];
  
  gradientLayer.borderWidth = 0;
}

-(void)addOverlayToView2:(UIView *)view
{
  if (!overlayContainer)
  {
    overlayContainer = [[UIView alloc] initWithFrame:view.bounds];
    overlayContainer.backgroundColor = [UIColor clearColor];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = overlayContainer.bounds;
    gradient.colors = @[(id)[[UIColor blackColor] CGColor], (id)[[UIColor clearColor] CGColor]];
    [overlayContainer.layer insertSublayer:gradient atIndex:0];
    [view addSubview:overlayContainer];
  }
}

@end
