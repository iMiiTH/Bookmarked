//
//  AppDelegate.m
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-04.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import "AppDelegate.h"

NSString *const NAME_IDENTIFIER = @"name";
NSString *const USER_IDENTIFIER = @"username";
NSString *const HOST_IDENTIFIER = @"host";
NSString *const PORT_IDENTIFIER = @"port";

NSString *const OSX_TERMINAL_IDENTIFIER = @"Terminal";
NSString *const ITERM_IDENTIFIER = @"iTerm";

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.bookmarkManager = [[MMBookmarkManager alloc]initWithWindow:self.bookmarkWindow];
    [self.bookmarkManager setDelegate:self];
    
    self.addWindowManager = [[MMAddBookmarkManager alloc]initWithWindow:self.addWindow];
    [self.addWindowManager setDelegate:self];
    [self.addWindowManager setNameField:self.nameField];
    [self.addWindowManager setUsernameField:self.usernameField];
    [self.addWindowManager setHostField:self.hostField];
    [self.addWindowManager setPortField:self.portField];
    
    self.defaults = [NSUserDefaults standardUserDefaults];

    NSLog(@"%@", [self.defaults dataForKey:@"bookmarks"]);

    if( [self.defaults dataForKey:@"bookmarks"] == nil) {
        NSLog(@"No stored array... creating new one.");
        self.bookmarkData = [[NSMutableArray alloc]init];
    } else {
        NSLog(@"Retrieving previously stored array...");
        NSData *data = [self.defaults objectForKey:@"bookmarks"];
        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.bookmarkData = [arr mutableCopy];
        [self reloadBookmarks];
    }
    if ( [self.defaults stringForKey:@"terminal"] == nil ) {
        NSLog(@"Setting terminal to OS X default.");
        self.terminal = OSX_TERMINAL_IDENTIFIER;
    } else {
        self.terminal = [self.defaults stringForKey:@"terminal"];
        NSLog(@"Restoring set terminal to: %@", self.terminal);
        [self.terminalButton setTitle:self.terminal];
    }
    
    //[self.bookmarkTable setDelegate:self];
    [self.bookmarkTable setDataSource:self];
}

- (void)awakeFromNib
{
    NSString *MyCustomPBoardType = @"MyCustomBoardType";
    NSArray *dragTypes = [NSArray arrayWithObjects: MyCustomPBoardType,nil];
    [self.bookmarkTable registerForDraggedTypes:dragTypes];
    [self.bookmarkTable  setDraggingSourceOperationMask:NSDragOperationCopy forLocal:NO];
    
    NSBundle *bundle = [NSBundle mainBundle];
    if ( ![[NSUserDefaults standardUserDefaults] stringForKey:@"AppleInterfaceStyle"]  ){
        self.menuIcon = [[NSImage alloc]initWithContentsOfFile:[bundle pathForResource:@"bookmarked_menu_icon_black@2x" ofType:@"png"]];
        self.alternateMenuIcon = [[NSImage alloc]initWithContentsOfFile:[bundle pathForResource:@"bookmarked_menu_icon_white@2x" ofType:@"png"]];
    } else {
        self.menuIcon = [[NSImage alloc]initWithContentsOfFile:[bundle pathForResource:@"bookmarked_menu_icon_white@2x" ofType:@"png"]];
        self.alternateMenuIcon = [[NSImage alloc]initWithContentsOfFile:[bundle pathForResource:@"bookmarked_menu_icon_white@2x" ofType:@"png"]];
    }
    
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setImage:self.menuIcon];
    [self.statusItem setAlternateImage:self.alternateMenuIcon];
    
    self.statusMenu = [[NSMenu alloc]init];
    
    NSMenuItem *temp = [[NSMenuItem alloc]initWithTitle:@"No bookmarks added" action:nil keyEquivalent:@""];
    [self.statusMenu addItem:temp];
    [self.statusMenu addItem:[NSMenuItem separatorItem]];
    
    self.preferencesItem = [[NSMenuItem alloc]initWithTitle:@"Preferences..." action:@selector(openPreferences:) keyEquivalent:@""];
    [self.preferencesItem setImage:[NSImage imageNamed:NSImageNameActionTemplate]];
    [self.statusMenu addItem:self.preferencesItem];
    
    self.exitItem = [[NSMenuItem alloc]initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    [self.exitItem setImage:[NSImage imageNamed:NSImageNameStopProgressTemplate]];
    [self.statusMenu addItem:self.exitItem];
    
    [self.statusItem setMenu:self.statusMenu];

    [self.terminalButton addItemWithTitle:OSX_TERMINAL_IDENTIFIER];
    [self.terminalButton addItemWithTitle:ITERM_IDENTIFIER];
    
    //self.scriptURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"applescripts" ofType:@"scpt"]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    NSLog(@"Closing application, removing icon from statusbar.");
    [[NSStatusBar systemStatusBar]removeStatusItem:self.statusItem];
    NSLog(@"Saving defaults");
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Button Commands

- (void)addButtonPressed:(id)sender
{
    NSLog(@"add button pressed");
    [self.addWindowManager showWindow];
}

- (void)removeButtonPressed:(NSButton *)sender
{
    NSLog(@"remove button pressed");
}

- (void)openPreferences:(NSButton *)sender
{
    [self.bookmarkManager showWindow];
}

#pragma mark - NSTAbleViewDataSource Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSLog(@"Number of rows in tableview requested... Value=%zu", [self.bookmarkData count]);
    return [self.bookmarkData count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //NSLog(@"Row: %zd Column: %@\n", (long)row, tableColumn.identifier);
    MMSSHBookmark *temp = [self.bookmarkData objectAtIndex:row];
    if( [tableColumn.identifier isEqualToString:NAME_IDENTIFIER] ) {
        return temp.menuTitle;
    } else if( [tableColumn.identifier isEqualToString:USER_IDENTIFIER] ) {
        return temp.username;
    } else if( [tableColumn.identifier isEqualToString:HOST_IDENTIFIER] ) {
        return temp.host;
    } else if( [tableColumn.identifier isEqualToString:PORT_IDENTIFIER] ) {
        return temp.port;
    } else {
        return nil;
    }
}
- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    MMSSHBookmark *temp = [self.bookmarkData objectAtIndex:row];
    // TODO: Finish this, update the edited cells
    if( [tableColumn.identifier isEqualToString:NAME_IDENTIFIER] ) {
        [temp setMenuTitle:object];
    } else if ( [tableColumn.identifier isEqualToString:USER_IDENTIFIER] ) {
        [temp setUsername:object];
    } else if ( [tableColumn.identifier isEqualToString:HOST_IDENTIFIER] ) {
        [temp setHost:object];
    } else if ( [tableColumn.identifier isEqualToString:PORT_IDENTIFIER] ) {
        [temp setPort:object];
    }
    NSLog(@"setting row object");
    [self reloadBookmarks];
}

#pragma mark - Bookmark Window Commands

- (void)removeBookmark
{
    //TODO: add listener for the delete key.
}
- (void)removeBookmark:(id)sender
{
    [self.bookmarkData removeObjectAtIndex:[self.bookmarkTable selectedRow]];
    [self reloadBookmarks];
}
- (void)addBookmark:(id)sender
{
    if( ![self.addWindowManager fieldsHaveAcceptedInformation] ){
        return;
    }
    [self.bookmarkData addObject:[self.addWindowManager retrieveBookmark]];
    [self.addWindowManager closeWindow];
    [self.addWindowManager clearFields];
    NSLog(@"Current array: %@", self.bookmarkData);
    [self reloadBookmarks];
}
- (void)cancelAddBookmark:(id)sender
{
    [self.addWindowManager clearFields];
    [self.addWindowManager closeWindow];
}
- (void)reloadBookmarks
{
    [self.bookmarkTable reloadData];
    if( [self.bookmarkData count]>0 ) {
        NSLog(@"Storing bookmarks in userdefaults...");
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.bookmarkData];
        [self.defaults setObject:data forKey:@"bookmarks"];
        [self.defaults synchronize];
    }
    [self reloadMenu];

}
- (void)reloadMenu
{
    [self.statusMenu removeAllItems];
    for(MMSSHBookmark *bm in self.bookmarkData) {
        MMSSHMenuItem *temp = [[MMSSHMenuItem alloc]initWithTitle:bm.menuTitle action:@selector(clicked:) keyEquivalent:@""];
        [temp setTarget:temp];
        [temp setDelegate:self];
        [temp setBookmark:bm];
        [self.statusMenu addItem:temp];
        NSLog(@"%@", bm);
    }
    
    [self.statusMenu addItem:[NSMenuItem separatorItem]];
    [self.statusMenu addItem:self.preferencesItem ];
    [self.statusMenu addItem:self.exitItem];
}
- (void)terminalChanged:(NSPopUpButton *)sender
{
    NSLog(@"Changed to: %@", [sender titleOfSelectedItem]);
    self.terminal = [sender titleOfSelectedItem];
    [self.defaults setObject:self.terminal forKey:@"terminal"];
    [self.defaults synchronize];
}
- (void)sshWithBookmark:(MMSSHBookmark *)bookmark
{
    /*
     tell application "Terminal"
     set currentTab to do script ("ssh user@server;")
     delay 6
     do script ("do something remote") in currentTab
     end tell
     */
    NSString *command;
    if( [self.terminal isEqualToString:OSX_TERMINAL_IDENTIFIER]){
        if( [bookmark.port length] < 1) {
            command = [NSString stringWithFormat:@"tell application \"Terminal\"\n"
                       "activate\n"
                       "do script(\"ssh %@@%@\")\n "
                       "end tell", bookmark.username, bookmark.host];
        } else {
            command = [NSString stringWithFormat:@"tell application \"Terminal\"\n"
                       "activate\n"
                       "do script(\"ssh -p %@ %@@%@\")\n "
                       "end tell",bookmark.port, bookmark.username, bookmark.host];
        }
    } else {
        if( [bookmark.port length] < 1){
            command = [NSString stringWithFormat:@"tell application \"iTerm\"\n"
                       "activate\n"
                       "try\n"
                       "tell the current terminal\n"
                       "activate current session\n"
                       "launch session \"Default\"\n"
                       "tell the last session\n"
                       "write text \"ssh mmohorov@moon.scs.ryerson.ca\"\n"
                       "end tell\n"
                       "end tell\n"
                       "on error\n"
                       "set myterm to (make new terminal)\n"
                       "tell myterm\n"
                       "launch session \"Default\"\n"
                       "tell the last session to write text \"ssh %@@%@\"\n"
                       "end tell\n"
                       "end try\n"
                       "end tell", bookmark.username, bookmark.host];
        } else {
            command = [NSString stringWithFormat:@"tell application \"iTerm\"\n"
                       "activate\n"
                       "try\n"
                       "tell the current terminal\n"
                       "activate current session\n"
                       "launch session \"Default\"\n"
                       "tell the last session\n"
                       "write text \"ssh mmohorov@moon.scs.ryerson.ca\"\n"
                       "end tell\n"
                       "end tell\n"
                       "on error\n"
                       "set myterm to (make new terminal)\n"
                       "tell myterm\n"
                       "launch session \"Default\"\n"
                       "tell the last session to write text \"ssh -p %@ %@@%@\"\n"
                       "end tell\n"
                       "end try\n"
                       "end tell", bookmark.port, bookmark.username, bookmark.host];
        }
    }
    //NSLog(@"Executing applescript: %@", command);
    NSDictionary *error;
    NSAppleScript* appleScript = [[NSAppleScript alloc] initWithSource: (NSString *)command];
    [appleScript compileAndReturnError:&error];
    //NSLog(@"Compile successful: %@", error);
    [appleScript executeAndReturnError:&error];
    //NSLog(@"Run successful: %@", error);
}
- (void)startupButtonPressed:(NSButton *)sender
{
    NSDictionary *error;
    NSLog(@"Startup button pressed.");
    NSAppleScript *a = [[NSAppleScript alloc] initWithSource:@"tell application \"System Preferences\"\nactivate\nset current pane to pane \"com.apple.preferences.users\"\nend tell"];
    [a executeAndReturnError:&error];
    //NSLog(@"%@",error)
}

@end
