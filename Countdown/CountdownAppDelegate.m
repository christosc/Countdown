//
//  TimerAppDelegate.m
//  Timer
//
//  Created by Christos Chryssochoidis on 4/18/11.
//  Copyright 2011 University of Athens. All rights reserved.
//

// Χρειάζεται νὰ ἔχω δύο χρονιστὰς, ἕνα ἐπαναλαμβανόμενον διὰ τὴν κατὰ 
// δευτερόλεπτον (ἢ λεπτὸν) ἀνανέωσιν τῆς ἐνδείξεως ἐν τῇ ράβδῳ καταστάσεως, 
// καὶ ἕνα πυροδοτούμενον ἐφάπαξ γιὰ νὰ παύσῃ τὸν προηγούμενον χρονιστήν.

#import "CountdownAppDelegate.h"

@implementation CountdownAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //--------------------  ΚΟΥΜΠΙΑ ---------------------------------
    
    //--------------------  Κουμπὶ ἐνάρξεως -------------------------
    
    view = [[NSView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [window setContentView:view];
    [view release];
    startButton = [[NSButton alloc] initWithFrame:CGRectMake(10, 10, 60, 50)];
    [startButton setTitle:@"Ἄρχισον"];
    [startButton setTarget:self];
    [startButton setAction:@selector(startCountdown:)];
    [view addSubview:startButton];
    [startButton release];
    
    
    //-------------------- Κουμπὶ παύσεως ---------------------------
    
    stopButton = [[NSButton alloc] initWithFrame:CGRectMake(90, 10, 60, 50)];
    [stopButton setTitle:@"Παῦσον"];
    [stopButton setTarget:self];
    [stopButton setAction:@selector(stopCountdown:)];
    [view addSubview:stopButton];
    [stopButton release];
    [stopButton setEnabled:NO];
    
    
    //--------------------- ΠΕΔΙΑ—ΕΠΙΓΡΑΦΑΙ -------------------------
    
    //--------------------- Προθεσμία -------------------------------
    
    timeoutLabel = [[NSTextField alloc] 
                    initWithFrame:CGRectMake(10, 100, 90, 20)];
    [timeoutLabel setStringValue:@"Προθεσμία:"];
    [timeoutLabel setEditable:NO];
    [timeoutLabel setDrawsBackground:NO];
    [timeoutLabel setBezeled:NO];
    [view addSubview:timeoutLabel];
    [timeoutLabel release]; 
    [timeoutLabel setAlignment:NSLeftTextAlignment];
    
    
    
    
    timeoutField = [[NSTextField alloc] 
                        initWithFrame:CGRectMake(100, 100, 40, 20)];
    [timeoutField setStringValue:[[NSNumber numberWithInt:DEFAULT_TIMEOUT] 
                                    stringValue]];
    [view addSubview:timeoutField];
    [timeoutField release];
    [timeoutField setAlignment:NSCenterTextAlignment];
    
    
    NSTextField *ending = [[NSTextField alloc] 
                           initWithFrame:CGRectMake(140, 100, 50, 20)];
    [ending setStringValue:@"λεπτά"];
    [ending setEditable:NO];
    [ending setDrawsBackground:NO];
    [ending setBezeled:NO];
    [view addSubview:ending];
    [ending release]; 
    [ending setAlignment:NSLeftTextAlignment];
    
    
    //-------------------- Ἐναπομένων χρόνος ----------------------
    
    remainingTimeLabel = [[NSTextField alloc] 
                    initWithFrame:CGRectMake(10, 70, 90, 20)];
    [remainingTimeLabel setStringValue:@"ἐναπομένων:"];
    [remainingTimeLabel setEditable:NO];
    [remainingTimeLabel setDrawsBackground:NO];
    [remainingTimeLabel setBezeled:NO];
    [view addSubview:remainingTimeLabel];
    [remainingTimeLabel release]; 
    [remainingTimeLabel setAlignment:NSLeftTextAlignment];
    
    
    
    
    remainingTimeField = [[NSTextField alloc] 
                    initWithFrame:CGRectMake(100, 70, 40, 20)];
//  [remainingTimeField setStringValue:[[NSNumber numberWithInt:DEFAULT_TIMEOUT] 
//                                  stringValue]];
    [view addSubview:remainingTimeField];
    [remainingTimeField release];
    [remainingTimeField setAlignment:NSCenterTextAlignment];
    [remainingTimeField setEditable:NO];
    
    
    ending = [[NSTextField alloc] 
                           initWithFrame:CGRectMake(140, 70, 50, 20)];
    [ending setStringValue:@"λεπτά"];
    [ending setEditable:NO];
    [ending setDrawsBackground:NO];
    [ending setBezeled:NO];
    [view addSubview:ending];
    [ending release]; 
    [ending setAlignment:NSLeftTextAlignment];
    
    
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent* ev){
        NSLog(@"From within keyboard event handler!!!");
        NSUInteger modifiers = [ev modifierFlags];
        NSString *chars = [ev charactersIgnoringModifiers];
        
        NSLog(@"modifiers = %ld", modifiers);
        NSUInteger modSought = modifiers & (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask);
        NSLog(@"modSought == (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask) == %d",
              modSought ==  (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask));  
        if (modSought ==  (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask)
            && [chars isEqualToString:@"c"]){
            NSLog(@"From within IF in keyboard event handler!!!");
            [self startCountdown:nil];
        }
    }];
    
        
    [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent*(NSEvent* ev){
        NSLog(@"From within keyboard event handler!!!");
        NSUInteger modifiers = [ev modifierFlags];
        NSString *chars = [ev charactersIgnoringModifiers];
        
        NSLog(@"modifiers = %ld", modifiers);
        NSUInteger modSought = modifiers & (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask);
        NSLog(@"modSought == (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask) == %d",
              modSought ==  (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask));  
        if (modSought ==  (NSControlKeyMask | NSCommandKeyMask | NSAlternateKeyMask)
            && [chars isEqualToString:@"c"]){
            NSLog(@"From within IF in keyboard event handler!!!");
            [self startCountdown:nil];
            return nil;
        }
        else
            return ev;
        
    }]; 
    
    
    
}

- (void)startCountdown:(id)sender
{
//    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
//    statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
//    [statusItem retain];
//    [statusItem setEnabled:YES];
//    [statusItem setToolTip:@"Ἐναπομένοντα λεπτά"];
    
    if ([timeoutTimer isValid]) {
        [self stopCountdown:nil];
    }
    
    timeout = (int)[timeoutField integerValue];
//    [timeoutField setEnabled:NO];
//    [timeoutField resignFirstResponder];
    [[timeoutField window] makeFirstResponder: nil];
    [timeoutField setDrawsBackground:NO];
    [timeoutField setSelectable:NO];
    [timeoutField setEditable:NO];
    
    [timeoutField setBezeled:NO];
    
    [timeoutField setNeedsDisplay:YES];
    remainingTime = timeout;
    
    NSString *initialStringValue = [[NSNumber numberWithInt:remainingTime] 
                                    stringValue];
//    [statusItem setTitle:initialStringValue];
    [remainingTimeField setStringValue:initialStringValue];
    
    NSDockTile *dockTile = [NSApp dockTile];
//    Badge *badge = [[[Badge alloc] initWithFrame:CGRectMake(0, 0, 256, 256)] autorelease];
//    NSLog(@"badge view = %@", [badge description]);
//    NSLog(@"badge subviews = %@", [[badge subviews] description]);
//    NSLog(@"badge bounds = %@", NSStringFromRect([badge bounds]));
//    [dockTile setContentView:badge];
//    [dockTile display];
//    [dockTile setShowsApplicationBadge:YES];
    [dockTile setBadgeLabel:initialStringValue];

    updateTimer = [NSTimer scheduledTimerWithTimeInterval:60 // κάθε 60δευτ.
                                                   target:self 
                                        selector:@selector(updateStatusItem:) 
                                                 userInfo:nil
                                                  repeats:YES];
    
    [updateTimer retain];
    timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:timeout * 60
                                                    target:self
                                            selector:@selector(stopCountdown:)
                                                  userInfo:nil
                                                   repeats:NO];
    [timeoutTimer retain];
    

    
    [startButton setEnabled:NO];
    [stopButton setEnabled:YES];
    
}

- (void)updateStatusItem:(id)sender
{
    NSTimer *timer = (NSTimer*)sender;
    remainingTime = (remainingTime*60 - [timer timeInterval]) / 60;
    NSString *newStringValue = [[NSNumber numberWithInt:remainingTime] 
                                     stringValue];
//    [statusItem setTitle:newStringValue];
    [remainingTimeField setStringValue:newStringValue];
    [[NSApp dockTile] setBadgeLabel:newStringValue];
}

- (void)stopCountdown:(id)sender
{
    // ἀκύρωσον τὸν timeoutTimer ἐὰν οὗτος εἶναι ἐνεργός (ὅταν πατῆται τὸ κουμπὶ
    // «παῦσον».
    if ([timeoutTimer isValid]) {
        [timeoutTimer invalidate];
    }
    
    if ([updateTimer isValid]) {
        [updateTimer invalidate];
    }
    
    
//    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
//    [statusBar removeStatusItem:statusItem];
//    [statusItem release];
    [remainingTimeField setStringValue:@"0"];
    
    [timeoutField setBezeled:YES];
//    [timeoutField setEnabled:YES];
    [timeoutField setSelectable:YES];
    [timeoutField setEditable:YES];
    [timeoutField setDrawsBackground:YES];
//    [timeoutField dr
    
    [[NSApp dockTile] setBadgeLabel:@""]; // ἀφαίρεσον τὸ σῆμα (badge)
    
    [stopButton setEnabled:NO];
    [startButton setEnabled:YES];
//    [[NSApp dockTile] setShowsApplicationBadge:NO];
//    NSLog(@"dock tile's content view = %@", [[[NSApp dockTile] contentView] description]);
    
}

//- (void)applicationWillTerminate:(NSNotification *)notification
//{
//    if (<#condition#>) {
//        <#statements#>
//    }
//}
@end
