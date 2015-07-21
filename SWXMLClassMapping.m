//
//  SWXMLClassMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLClassMapping.h"


@implementation SWXMLClassMapping

@synthesize objectClassName = _objectClassName, tag = _tag, members = _members, attributes = _attributes;

- (NSArray *)membersForObject:(id)object withMapping:(SWXMLMapping *)mapping {
	NSMutableArray * children = [NSMutableArray new];
	
	for (SWXMLMemberMapping * memberMapping in self.members) {
		NSString * child = [memberMapping serializedObjectMember:object withMapping:mapping];
		
		if (child && child.length > 0)
			[children addObject:child];
	}
	
	return children;
}

- (NSString *)serializeObject:(id)object withMapping:(SWXMLMapping*)mapping {
	NSArray * children = [self membersForObject:object withMapping:mapping];
	NSDictionary * attributes = nil;
	
	if ((self.attributes)[@"id"]) {
		id objectIdentificationKeyPath = (self.attributes)[@"id"];
		
		// Wee shortcut
		if ([objectIdentificationKeyPath isEqualTo:@"managed-object"]) {
			objectIdentificationKeyPath = @"objectID.URIRepresentation";
		}
		
		id objectIdentification = [object valueForKeyPath:objectIdentificationKeyPath];
		attributes = @{@"id": objectIdentification};
	}
	
	return [SWXMLTags tagNamed:self.tag forValue:[children componentsJoinedByString:@"\n"] withAttributes:attributes];
}

- (instancetype) initWithTag:(NSString*)tag forClass:(NSString*)className attributes:(NSDictionary *)attributes {
	self = [super init];
	
	if (self) {
		self.tag = tag;
		self.objectClassName = className;
		self.attributes = attributes;
	}
	
	return self;
}


@end
