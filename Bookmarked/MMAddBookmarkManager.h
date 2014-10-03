//
//  MMAddBookmarkManager.h
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-07.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "MMSSHBookmark.h"

@interface MMAddBookmarkManager : NSObject

@property (nonatomic) id delegate;
@property (nonatomic) NSWindow *window;
 
@property (nonatomic) NSTextField *nameField;
@property (nonatomic) NSTextField *usernameField;
@property (nonatomic) NSTextField *hostField;
@property (nonatomic) NSTextField *portField;


- (id)initWithWindow: (NSWindow *)window;

- (void)showWindow;
- (void)closeWindow; //when called, will add a new addition to the array of MMSSHBookmarks.
- (void)clearFields;
- (MMSSHBookmark *)retrieveBookmark;
- (BOOL)fieldsHaveAcceptedInformation;

@end
