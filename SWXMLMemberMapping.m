//
//  SWXMLMemberMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMemberMapping.h"


@implementation SWXMLMemberMapping

@synthesize tag = _tag, keyPath = _keyPath, attributes = _attributes;

- (id)initWithTag:(NSString *)tag keyPath:(NSString *)keyPath attributes:(NSDictionary *)attributes {
	self = [super init];
	
	if (self) {
		self.tag = tag;
		self.keyPath = keyPath;
		self.attributes = attributes;
	}
	
	return self;
}

- (void) dealloc {
	self.tag = nil;
	self.keyPath = nil;
	self.attributes = nil;
	
	[super dealloc];
}

- initWithAttributes: (NSDictionary*)attributes {
	return [self initWithTag:[attributes valueForKey:@"tag"] keyPath:[attributes valueForKey:@"keyPath"] attributes:attributes];
}

- (NSString*) serializedObjectMember:(id) object withMapping:(SWXMLMapping*)mapping {
	return [mapping serializeObject:[object valueForKeyPath:self.keyPath]];
}

@end
