//
//  MMSSHMenuItem.h
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-12.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMSSHBookmark.h"
#import "AppDelegate.h"

@interface MMSSHMenuItem : NSMenuItem

@property MMSSHBookmark *bookmark;
@property id delegate;

- (void)clicked:(id)sender;

@end
