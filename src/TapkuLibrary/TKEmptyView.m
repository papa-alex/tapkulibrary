//
//  TKEmptyView.m
//  Created by Devin Ross on 7/24/09.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKEmptyView.h"
#import "TKGlobal.h"
#import "UIImage+TKCategory.h"
#import "UIView+TKCategory.h"

@interface TKEmptyView()

- (UIImage*) maskedImageWithImage:(UIImage*)m;


@end



@implementation TKEmptyView
@synthesize imageView,titleLabel,subtitleLabel;

- (UIImage*) predefinedImage:(TKEmptyViewImage)img{
	
	NSString *str; 


	
	switch (img) {
		case TKEmptyViewImageChatBubble:
			str = @"chatbubble";
			break;
		case TKEmptyViewImageClock:
			str = @"clock";
			break;
		case TKEmptyViewImageCompass:
			str = @"compass";
			break;
		case TKEmptyViewImageEye:
			str = @"eye";
			break;
		case TKEmptyViewImageHeart:
			str = @"heart";
			break;
		case TKEmptyViewImageMovieClip:
			str = @"movieclip";
			break;
		case TKEmptyViewImageMusicNote:
			str = @"note";
			break;
		case TKEmptyViewImagePhotos:
			str = @"photos";
			break;
		case TKEmptyViewImagePictureFrame:
			str = @"pictureframe";
			break;
		case TKEmptyViewImageSearch:
			str = @"search";
			break;
		case TKEmptyViewImageSign:
			str = @"sign";
			break;
		case TKEmptyViewImageStar:
			str = @"star";
			break;
		case TKEmptyViewImageStopwatch:
			str = @"stopwatch";
			break;
		case TKEmptyViewImageKey:
			str = @"key";
			break;
		default:
			str = @"star";
			break;
	}
	
	NSString *scale = @"";
	if([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
		NSInteger s = [[UIScreen mainScreen] scale];
		if(s > 1) scale = @"@2x";
	}

	NSString *path = [NSString stringWithFormat:@"TapkuLibrary.bundle/Images/empty/%@%@.png",str,scale];
	return [UIImage imageWithContentsOfFile:TKBUNDLE(path)];
}


- (id) initWithFrame:(CGRect)frame mask:(UIImage*)image title:(NSString*)titleString subtitle:(NSString*)subtitleString{
	if(self = [super initWithFrame:frame]){
		
		
		self.backgroundColor = [UIColor whiteColor];
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:18];
		titleLabel.textColor = [UIColor colorWithRed:128/255. green:136/255. blue:149/255. alpha:1];
		titleLabel.textAlignment = UITextAlignmentCenter;
		titleLabel.shadowColor = [UIColor whiteColor];
		titleLabel.shadowOffset = CGSizeMake(0, 1);
		
		titleLabel.text = titleString;
		
		subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		subtitleLabel.backgroundColor = [UIColor clearColor];
		subtitleLabel.font = [UIFont systemFontOfSize:14];
		subtitleLabel.textColor = [UIColor colorWithRed:128/255. green:136/255. blue:149/255. alpha:1];
		subtitleLabel.textAlignment = UITextAlignmentCenter;
		subtitleLabel.shadowColor = [UIColor whiteColor];
		subtitleLabel.shadowOffset = CGSizeMake(0, 1);
		
		subtitleLabel.text = subtitleString;
		
		imageView = [[UIImageView alloc] initWithImage:[self maskedImageWithImage:image]];
		
		
		[self addSubview:imageView];
		[self addSubview:subtitleLabel];
		[self addSubview:titleLabel];
		

		
	}
	return self;
	
}
- (id) initWithFrame:(CGRect)frame emptyViewImage:(TKEmptyViewImage)image title:(NSString*)titleString subtitle:(NSString*)subtitleString{
	return [self initWithFrame:frame mask:[self predefinedImage:image] title:titleString subtitle:subtitleString];
}
- (id) initWithFrame:(CGRect)frame {
	return [self initWithFrame:frame emptyViewImage:TKEmptyViewImageStar title:@"" subtitle:@""];
}

- (void) drawRect:(CGRect)rect{
	
	
	//CGContextRef context = UIGraphicsGetCurrentContext();

	
	UIColor *top = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1];
	UIColor *bot = [UIColor colorWithRed:225/255.0 green:229/255.0 blue:235/255.0 alpha:1];
	
	[UIView drawGradientInRect:rect withColors:[NSArray arrayWithObjects:top,bot,nil]];
	


}

- (void) layoutSubviews{
	[super layoutSubviews];
	
	CGRect rect = self.frame;

	titleLabel.frame = CGRectMake(0, 0, rect.size.width, 20);
	subtitleLabel.frame = CGRectMake(0, 0, rect.size.width, 16);
	
	imageView.center = CGPointMake(rect.size.width/2, rect.size.height/2 - rect.size.height/12 );
	imageView.frame = CGRectMake((int)imageView.frame.origin.x, (int)imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
	
	
	titleLabel.center = CGPointMake(rect.size.width/2, MAX(rect.size.height/2 +  rect.size.height/4,imageView.frame.origin.y+imageView.frame.size.height+14));
	subtitleLabel.center = CGPointMake(titleLabel.center.x, titleLabel.center.y + 20);

		
	
	
	
	
	//imageView.backgroundColor = [UIColor redColor];
	
}


- (void) setImage:(UIImage*)image{
	//imageView.image = image;
	imageView.image = [self maskedImageWithImage:image];
	[self layoutSubviews];
	[self setNeedsDisplay];
}
- (void) setEmptyImage:(TKEmptyViewImage)image{
	[self setImage:[self predefinedImage:image]];
}
- (UIImage*) maskedImageWithImage:(UIImage*)m{
	
	if(m==nil) return nil;

	UIGraphicsBeginImageContext(CGSizeMake((m.size.width)*m.scale , (m.size.height+2)*m.scale));
	CGContextRef context = UIGraphicsGetCurrentContext();

	NSArray *colors = [NSArray arrayWithObjects:
				   [UIColor colorWithRed:174/255.0 green:182/255.0 blue:195/255.0 alpha:1],
				   [UIColor colorWithRed:197/255.0 green:202/255.0 blue:211/255.0 alpha:1],nil];
	
	//CGFloat colors[] = { 174/255.0, 182/255.0, 195/255.0, 1.00, 197/255.0, 202/255.0, 211/255.0, 1.00};

	CGContextSetShadowWithColor(context, CGSizeMake(1, 4),4, [UIColor colorWithWhite:0 alpha:0.1].CGColor);
	[m drawInRect:CGRectMake(0, 0+(1*m.scale),m.size.width, m.size.height)];
	//[m drawInRect:CGRectMake(0, 0, m.size.width*m.scale, m.size.height*m.scale) asAlphaMaskForGradient:colors];
	[m drawMaskedGradientInRect:CGRectMake(0, 0, m.size.width*m.scale, m.size.height*m.scale) withColors:colors];
	
	UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	UIImage *scaledImage = [UIImage imageWithCGImage:image.CGImage scale:m.scale orientation:UIImageOrientationUp];
	

	
	return scaledImage;
}


- (void) dealloc {
	
	[subtitleLabel release];
	[titleLabel release];
	[imageView release];
	
    [super dealloc];
}


@end
