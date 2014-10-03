//
//  AppDelegate.h
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-04.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMBookmarkManager.h"
#import "MMSSHMenuItem.h"

FOUNDATION_EXPORT NSString *const NAME_IDENTIFIER;
FOUNDATION_EXPORT NSString *const USER_IDENTIFIER;
FOUNDATION_EXPORT NSString *const HOST_IDENTIFIER;
FOUNDATION_EXPORT NSString *const PORT_IDENTIFIER;
FOUNDATION_EXPORT NSString *const OSX_TERMINAL_IDENTIFIER;
FOUNDATION_EXPORT NSString *const ITERM_IDENTIFIER;

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>

@property (nonatomic) NSUserDefaults *defaults;
@property (nonatomic) NSMutableArray *bookmarkData;
@property (nonatomic) NSString *terminal;
@property (nonatomic) NSURL *scriptURL; 

@property (nonatomic) NSMenu *menu;
@property (nonatomic) NSStatusItem *statusItem;
@property (nonatomic) NSMenu *statusMenu;

@property (nonatomic) NSMenuItem *preferencesItem;
@property (nonatomic) NSMenuItem *exitItem;

@property (nonatomic) NSImage *menuIcon;
@property (nonatomic) NSImage *alternateMenuIcon;

@property (nonatomic) IBOutlet NSButton *startupButton;
@property (nonatomic) IBOutlet NSPopUpButton *terminalButton;
@property (nonatomic) IBOutlet NSWindow *bookmarkWindow;
@property (nonatomic) IBOutlet NSTableView *bookmarkTable;

@property (nonatomic) IBOutlet NSWindow *addWindow;

@property (nonatomic) IBOutlet NSTextField *nameField;
@property (nonatomic) IBOutlet NSTextField *usernameField;
@property (nonatomic) IBOutlet NSTextField *hostField;
@property (nonatomic) IBOutlet NSTextField *portField;

@property (nonatomic) MMBookmarkManager *bookmarkManager;
@property (nonatomic) MMAddBookmarkManager *addWindowManager;

- (IBAction)removeButtonPressed:(NSButton *)sender;
- (IBAction)addButtonPressed:(id)sender;
- (void)openPreferences:(NSButton *)sender;
- (IBAction)removeBookmark;
- (IBAction)addBookmark:(id)sender;
- (IBAction)cancelAddBookmark:(id)sender;
- (void)reloadBookmarks;
- (void)reloadMenu;
- (IBAction)terminalChanged:(NSPopUpButton *)sender;
- (void)sshWithBookmark:(MMSSHBookmark *)bookmark;
- (IBAction)startupButtonPressed:(NSButton *)sender;

@end

