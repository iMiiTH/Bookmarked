//
//  MMAddBookmarkManager.m
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-07.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import "MMAddBookmarkManager.h"

@implementation MMAddBookmarkManager

- (id)init
{
    self = [super init];
    return self;
}
- (id)initWithWindow:(NSWindow *)window
{
    self = [self init];
    if(self){
        self.window = window;
    }
    return self;
}
- (void)showWindow
{
    [self.window makeKeyAndOrderFront:self];
    [self.window setOrderedIndex:0];
    [NSApp activateIgnoringOtherApps:YES];
    [self.window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
}

- (void)closeWindow
{
    [self.window close];
}

- (void)clearFields
{
    [self.nameField setStringValue:@""];
    [self.hostField setStringValue:@""];
    [self.portField setStringValue:@""];
    [self.usernameField setStringValue:@""];
}

- (MMSSHBookmark *)retrieveBookmark
{
    MMSSHBookmark *temp;
    temp = [[MMSSHBookmark alloc]initWithTitle:[self.nameField stringValue] UserName:[self.usernameField stringValue] AndHost:[self.hostField stringValue]];
    NSLog(@"Created bookmark: %@", temp);
    if( [[self.portField stringValue] length ]> 0) {
        [temp setPort:[self.portField stringValue]];
    }
    return temp;
}
- (BOOL)fieldsHaveAcceptedInformation
{
    if( !([[self.hostField stringValue]length]>0) ){
        [self.hostField becomeFirstResponder];
        return NO;
    } else if ( !([[self.usernameField stringValue]length]>0)) {
        [self.usernameField becomeFirstResponder];
        return NO;
    } else if( !([[self.hostField stringValue]length]>0)) {
        [self.hostField becomeFirstResponder];
        return NO;
    } else {
        return YES;
    }
}
@end
