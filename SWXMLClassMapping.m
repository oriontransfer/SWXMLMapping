//
//  SWXMLClassMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLClassMapping.h"


@implementation SWXMLClassMapping

- (NSString*) serializeObject: (id)object withMapping: (SWXMLMapping*)mapping {
	id i = [members objectEnumerator];
	SWXMLMemberMapping *memberMapping;
	
	//NSMutableDictionary *attributes = [NSMutableDictionary new];
	NSMutableArray *children = [[NSMutableArray new] autorelease];
	
	while ((memberMapping = [i nextObject]) != nil) {
		[children addObject:[memberMapping serializedObjectMember:object withMapping:mapping]];
	}
	
	return [SWXMLTags tagNamed:self->tag forValue:[children componentsJoinedByString:@"\n"]];
}

- initWithTag: (NSString*)tagName forClass: (NSString*)className {
	self = [super init];
	
	if (self) {
		self->tag = [tagName retain];
		self->objectClassName = [className retain];
	}
	
	return self;
}

- (void) dealloc {
	[tag release];
	[objectClassName release];
	
	[super dealloc];
}


- (void) setMembers: (NSArray*)newMembers {
	[self->members release];
	self->members = [newMembers retain];
}

- (NSArray*) members {
	return [[self->members retain] autorelease];
}

- (NSString*) tag {
	return [[tag retain] autorelease];
}

- (NSString*) objectClassName {
	return [[objectClassName retain] autorelease];
}

@end
