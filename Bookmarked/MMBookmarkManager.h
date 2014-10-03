//
//  MMBookmarkManager.h
//  Bookmarked
//
//  Created by Mitchell Mohorovich on 2014-08-07.
//  Copyright (c) 2014 Mitchell Mohorovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAddBookmarkManager.h"

@interface MMBookmarkManager : NSObject

@property (nonatomic, assign) id delegate;

@property (nonatomic) NSWindow *window;

@property (nonatomic) MMAddBookmarkManager *addManager;
@property (nonatomic) NSMutableArray *bookmarks;

- (id)initWithWindow:(NSWindow *)window;

- (void)showWindow;
- (NSInteger)count;

@end
