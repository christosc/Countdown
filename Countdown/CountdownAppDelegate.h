//
//  CountdownAppDelegate.h
//  Countdown
//
//  Created by Christos Chryssochoidis on 4/19/11.
//  Copyright 2011 University of Athens. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CountdownAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
