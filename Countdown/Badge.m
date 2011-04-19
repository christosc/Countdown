//
//  Badge.m
//  Countdown
//
//  Created by Christos Chryssochoidis on 4/19/11.
//  Copyright 2011 University of Athens. All rights reserved.
//

#import "Badge.h"


@implementation Badge

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //NSImage *appIcon = [NSImage imageNamed:@"redBadge"];
    //    NSString *badgeFile = [[NSBundle mainBundle] pathForImageResource:@"greenBadge.tiff"];
    //    NSString *appIconFile = [[NSBundle mainBundle] pathForImageResource:@"APPL.icns"];
        
        NSImage *badgeImg = [[NSImage alloc] initWithContentsOfFile:@"greenBadge.tiff"];
        NSImage *appIcon = [[NSImage alloc] initWithContentsOfFile:@"APPL.icns"];
        appIconView = [[NSImageView alloc] init];
        [appIconView setImage:appIcon];
        [appIcon release];
        
        
        badgeView = [[NSImageView alloc] init];
        [badgeView setImage:badgeImg];
        [badgeImg release];
        [self addSubview:appIconView];
        [self addSubview:badgeView];
        NSLog(@"badge from within init: %@", [self description]);
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setBadgeON:(BOOL)on
{
    
    if (on == YES) {
        NSString *redBadgeFile = [[NSBundle mainBundle] pathForImageResource:@"redBadge.tiff"];
        NSImage *redBadge = [NSImage imageNamed:redBadgeFile];
        [badgeView setImage:redBadge];
    }
    else {
        NSString *redBadgeFile = [[NSBundle mainBundle] pathForImageResource:@"greenBadge.tiff"];
        NSImage *redBadge = [NSImage imageNamed:redBadgeFile];
        [badgeView setImage:redBadge];
    }
}


- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
