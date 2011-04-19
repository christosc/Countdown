//
//  TimerAppDelegate.h
//  Timer
//
//  Created by Christos Chryssochoidis on 4/18/11.
//  Copyright 2011 University of Athens. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Badge.h"
#define DEFAULT_TIMEOUT 120  //ἀριθμὸς λεπτῶν τῆς ὥρας δι' ἐκπνοὴν τῆς ἀντιστρόφου 
                            // μετρήσεως

@interface CountdownAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    NSView *view;
//    NSStatusItem *statusItem;
    NSButton *startButton;
    NSButton *stopButton;
    NSTextField *timeoutLabel;
    NSTextField *timeoutField;  // λεπτὰ προθεσμίας
    NSTextField *remainingTimeLabel;
    NSTextField *remainingTimeField;  // λεπτὰ ἐναπομένοντος χρόνου
    NSTimer *updateTimer; // χρονιστὴς δι' ἀνανέωσιν ἀνὰ λεπτὸν τῆς 
                       // ἐνδείξεως
    NSTimer *timeoutTimer; // χρονιστὴς διὰ παῦσιν τοῦ secTimer ἐπὶ τῇ ἐκπνοῇ 
                           // τῆς προθεσμίας
//    int timeout;  // ἀριθμὸς λεπτῶν τῆς ὥρας δι' ἐκπνοὴν τῆς ἀντιστρόφου 
//                     // μετρήσεως
    int remainingTime; // ἐναπομένοντα λεπτά δι' ἐκπνοὴν τῆς ἀντ.μετρήσεως
    int timeout;
}

@property (assign) IBOutlet NSWindow *window;

@end
