//
//  SWXMLClassMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLClassMapping.h"


@implementation SWXMLClassMapping

@synthesize objectClassName = _objectClassName, tag = _tag, members = _members;

- (NSString*) serializeObject: (id)object withMapping: (SWXMLMapping*)mapping {
	NSMutableArray * children = [[NSMutableArray new] autorelease];
	
	for (SWXMLMemberMapping * memberMapping in self.members) {
		[children addObject:[memberMapping serializedObjectMember:object withMapping:mapping]];
	}
	
	return [SWXMLTags tagNamed:self.tag forValue:[children componentsJoinedByString:@"\n"]];
}

- initWithTag: (NSString*)tag forClass: (NSString*)className {
	self = [super init];
	
	if (self) {
		self.tag = tag;
		self.objectClassName = className;
	}
	
	return self;
}

- (void) dealloc {
	self.tag = nil;
	self.objectClassName = nil;
	self.members = nil;
	
	[super dealloc];
}

@end
