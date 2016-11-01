//
//  NSObject+clarifaiObject.m
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "clarifaiObject.h"
#import <UIKit/UIKit.h>
#import <Clarifai/ClarifaiApp.h>
#import "foodhackathon-Swift.h"

@implementation clarifaiObject
@synthesize delegate;

NSString *string = @"";

- (void)recognizeImage:(UIImage *)image {
    
    // Initialize the Clarifai app with your app's ID and Secret.
    ClarifaiApp *app = [[ClarifaiApp alloc] initWithAppID:@"vQ1cAQVeRH42PgBuG5Ewv_ePUW9lHaqtjVN3NoXB"
                                                appSecret:@"R40jYtP5NsZHaSXdeSpBwNcCQxrZ6uLwrohwQ1WK"];
    
    // Fetch Clarifai's general model.
    [app getModelByName:@"food-items-v1.0" completion:^(ClarifaiModel *model, NSError *error) {
        // Create a Clarifai image from a uiimage.
        ClarifaiImage *clarifaiImage = [[ClarifaiImage alloc] initWithImage:image];
        
        // Use Clarifai's general model to pedict tags for the given image.
        [model predictOnImages:@[clarifaiImage] completion:^(NSArray<ClarifaiOutput *> *outputs, NSError *error) {
            if (!error) {
                ClarifaiOutput *output = outputs[0];
                
                // Loop through predicted concepts (tags), and display them on the screen.
                NSMutableArray *tags = [NSMutableArray array];
                for (ClarifaiConcept *concept in output.concepts) {
                    [tags addObject:concept.conceptName];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate performSegue:tags[0]];
                    NSLog(@"SEND TO DELEGATE");
                });
            }
        }];
    }];
}


@end
