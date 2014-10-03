//
//  MMSSHMenuItem.m
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-12.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import "MMSSHMenuItem.h"

@implementation MMSSHMenuItem

- (void)clicked:(id)sender
{
    [self.delegate sshWithBookmark:self.bookmark];
}

@end
