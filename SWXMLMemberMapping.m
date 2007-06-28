//
//  SWXMLMemberMapping.m
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import "SWXMLMemberMapping.h"


@implementation SWXMLMemberMapping

- initWithTag: (NSString*)newTag keyPath: (NSString*)newKeyPath attributes: (NSDictionary*)newAttributes {
	if (self == [super init]) {
		self->tag = [newTag retain];
		self->keyPath = [newKeyPath retain];
		self->attributes = [newAttributes retain];
	}
	
	return self;
}

- (void) dealloc {
	[tag release];
	[keyPath release];
	[attributes release];
	
	[super dealloc];
}


- initWithAttributes: (NSDictionary*)attrs {
	return [self initWithTag:[attrs valueForKey:@"tag"] keyPath:[attrs valueForKey:@"keyPath"] attributes:attrs];
}

- (NSString*) serializedObjectMember: (id) object withMapping: (SWXMLMapping*)mapping {
	return [mapping serializeObject:[object valueForKeyPath:self->keyPath]];
}

- (NSString*) keyPath {
	return [[self->keyPath retain] autorelease];
}

- (NSString*) tag {
	return [[self->tag retain] autorelease];
}

@end
