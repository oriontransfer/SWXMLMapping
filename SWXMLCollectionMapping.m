//
//  SWXMLCollectionMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLCollectionMapping.h"


@implementation SWXMLCollectionMapping

@synthesize objectClassName = _objectClassName, filterClassName = _filterClassName;

- initWithTag: (NSString*)tag keyPath: (NSString*)keyPath attributes: (NSDictionary*)attributes {
	self = [super initWithTag:tag keyPath:keyPath attributes:attributes];
	
	if (self) {
		self.filterClassName = [attributes valueForKey:@"filter"];
		self.objectClassName = [attributes valueForKey:@"class"];
	}
	
	return self;
}

- serializedObjectMember: (id)object withMapping: (SWXMLMapping*)mapping {
	id collection = [object valueForKeyPath:[self keyPath]];
	
	// This might be considered too simple as it won't catch derived classes, but it is fine for now...
	if (self.filterClassName) {
		NSMutableArray * items = [NSMutableArray array];
		
		for (id item in collection) {
			if ([[item className] isEqualToString:self.filterClassName])
				[items addObject:item];
		}
		
		collection = items;
	}
	
	if ([collection count] == 0)
		return nil;
	
	SWXMLClassMapping * classMapping = nil;
	
	if (self.objectClassName) {
		classMapping = [mapping.objectMappings objectForKey:self.objectClassName];
	}
	
	NSString * buffer = [mapping serializeObject:collection withClassMapping:classMapping];
	return [SWXMLTags tagNamed:self.tag forValue:buffer];
}

@end
