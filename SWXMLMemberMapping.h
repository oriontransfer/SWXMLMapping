//
//  SWXMLMemberMapping.h
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SWXMLTags.h"
#import "SWXMLMapping.h"

@class SWXMLMapping;

@interface SWXMLMemberMapping : NSObject {
	NSString *tag;
	NSString *keyPath;
	NSDictionary *attributes;
}

- initWithTag: (NSString*)tag keyPath: (NSString*)keyPath attributes: (NSDictionary*)attributes;
- initWithAttributes: (NSDictionary*)attributes;

- (NSString*) serializedObjectMember: (id) object withMapping: (SWXMLMapping*)mapping;

- (NSString*) keyPath;
- (NSString*) tag;

@end
