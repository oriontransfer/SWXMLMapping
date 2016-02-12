//
//  SWXMLMemberMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMemberMapping.h"
#import "SWXMLClassMapping.h"

@implementation SWXMLMemberMapping

@synthesize tag = _tag, keyPath = _keyPath, attributes = _attributes;

- (instancetype)initWithTag:(NSString *)tag keyPath:(NSString *)keyPath attributes:(NSAttributeDictionary *)attributes {
	self = [super init];
	
	if (self) {
		self.tag = tag;
		self.keyPath = keyPath;
		self.attributes = attributes;

		self.objectClassName = [attributes valueForKey:@"class"];
	}
	
	return self;
}


- (instancetype) initWithAttributes: (NSDictionary*)attributes {
	return [self initWithTag:[attributes valueForKey:@"tag"] keyPath:[attributes valueForKey:@"keyPath"] attributes:attributes];
}

- (NSString*) serializedObjectMember:(id) object withMapping:(SWXMLMapping*)mapping {
	SWXMLClassMapping * classMapping = nil;
	
	if (self.objectClassName) {
		classMapping = (mapping.objectMappings)[self.objectClassName];
	}

	return [mapping serializeObject:[object valueForKeyPath:self.keyPath] withClassMapping:classMapping];
}

@end
