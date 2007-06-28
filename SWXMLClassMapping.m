//
//  SWXMLClassMapping.m
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import "SWXMLClassMapping.h"


@implementation SWXMLClassMapping

- (NSString*) serializeObject: (id)object withMapping: (SWXMLMapping*)mapping {
	id i = [members objectEnumerator];
	SWXMLMemberMapping *memberMapping;
	
	//NSMutableDictionary *attributes = [NSMutableDictionary new];
	NSMutableArray *children = [NSMutableArray new];
	
	while ((memberMapping = [i nextObject]) != nil) {
		[children addObject:[memberMapping serializedObjectMember:object withMapping:mapping]];
	}
	
	return [SWXMLTags tagNamed:self->tag forValue:[children componentsJoinedByString:@"\n"]];
}

- initWithTag: (NSString*)tagName forClass: (NSString*)className {
	if (self == [super init]) {
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
