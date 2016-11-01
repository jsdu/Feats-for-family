//
//  NSObject+clarifaiObject.h
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol clarifaiObjectDelegate <NSObject>

-(void)performSegue:(NSString *)searchStr;

@end

@interface clarifaiObject: NSObject
- (void)recognizeImage:(UIImage *)image;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@property(weak, nonatomic) id<clarifaiObjectDelegate>delegate;

@end
