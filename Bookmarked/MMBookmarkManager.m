//
//  MMBookmarkManager.m
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-07.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import "MMBookmarkManager.h"

@implementation MMBookmarkManager

- (id)initWithWindow:(NSWindow *)window
{
    self.window = window;
    return self;
}

- (void)showWindow
{
    [self.window makeKeyAndOrderFront:self];
    [self.window setOrderedIndex:0];
    [NSApp activateIgnoringOtherApps:YES];
    [self.window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
    //[self.window setLevel:NSStatusWindowLevel];
}

- (void)addButton
{
    
}

- (NSInteger)count
{
    return [self.bookmarks count];
}
@end
