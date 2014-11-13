//
//  MMSSHBookmark.h
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-07.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AppKit;

@interface MMSSHBookmark : NSObject <NSCoding, NSPasteboardReading>

@property (nonatomic) NSString *menuTitle;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *host;
@property (nonatomic) NSString *port;

- (NSString *)description;
- (id)initWithTitle: (NSString *)title UserName: (NSString *)username AndHost: (NSString *)host;
- (id)initWithTitle: (NSString *)title UserName: (NSString *)username Host: (NSString *)host AndPort:(NSString *)port;

@end
