//
//  SWXMLClassMapping.h
//  Property Manager
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMapping.h"
#import "SWXMLMemberMapping.h"

@class SWXMLMapping, SWXMLMemberMapping;

@interface SWXMLClassMapping : NSObject {
	//Class objectClass;
	NSString *objectClassName;
	NSString *tag;
	NSArray *members;
	// List of tags (SWXMLMemberMapping)
}

- initWithTag: (NSString*)tag forClass: (NSString*)objectClassName;

- (NSString*) serializeObject: (id)object withMapping: (SWXMLMapping*)mapping;

- (void) setMembers: (NSArray*)members;
- (NSArray*) members;

- (NSString*) tag;
- (NSString*) objectClassName;

@end
