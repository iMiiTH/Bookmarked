//
//  MMSSHBookmark.m
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-07.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import "MMSSHBookmark.h"

@implementation MMSSHBookmark

- (NSString *) description
{
    return [NSString stringWithFormat:@"[Title=%@, Username=%@, Host=%@, Port=%@", self.menuTitle, self.username, self.host, self.port];
}

#pragma mark - Inits
- (id)init
{
    self = [super init];
    if(self) {
        self.menuTitle=nil;
        self.username=nil;
        self.host=nil;
        self.port=nil;
    }
    return self;
}
- (id)initWithTitle:(NSString *)title UserName:(NSString *)username AndHost:(NSString *)host
{
    self = [self init];
    if(self){
        self.menuTitle=title;
        self.username=username;
        self.host=host;
    }
    return self;
}
- (id)initWithTitle:(NSString *)title UserName:(NSString *)username Host:(NSString *)host AndPort:(NSString *)port
{
    self = [self init];
    if(self){

        self.port=port;
    }
    return self;
}
#pragma mark - Serialization
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]){
        self.menuTitle = [aDecoder decodeObjectForKey:@"menutitle"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.host = [aDecoder decodeObjectForKey:@"host"];
        self.port = [aDecoder decodeObjectForKey:@"port"];
    }
    return self;
}
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.menuTitle forKey:@"menutitle"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.host forKey:@"host"];
    [aCoder encodeObject:self.port forKey:@"port"];
}
@end
