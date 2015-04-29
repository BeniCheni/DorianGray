//
//  User.m
//  DorianGray
//
//  Created by Beni Cheni on 4/19/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = userDictionary[@"id"];
        self.userName = userDictionary[@"username"];
        self.fullName = userDictionary[@"full_name"];
        
        NSString *profileURLString = userDictionary[@"profile_picture"];
        NSURL *profileURL = [NSURL URLWithString:profileURLString];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
    }
    
    return self;
}

@end
