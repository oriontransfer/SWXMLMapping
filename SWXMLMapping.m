//
//  SWXMLMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMapping.h"
#import "SWXMLMappingParser.h"
#import "SWXMLClassMapping.h"

@implementation SWXMLMapping

@synthesize objectMappings = _objectMappings, metadata = _metadata;

+ (SWXMLMapping*) mappingFromURL:(NSURL*)schemaURL {
	SWXMLMappingParser * parser = [[SWXMLMappingParser alloc] initWithURL:schemaURL];
	SWXMLMapping * mapping = [[SWXMLMapping alloc] init];
	
	mapping.objectMappings = [parser parse];
	
	return mapping;
}

- (instancetype) init {
	self = [super init];

	if (self) {
		self.metadata = [NSMutableDictionary new];
	}

	return self;
}

- (instancetype) initWithMapping:(SWXMLMapping *)mapping andMetadata:(SWXMLMetadata *)metadata {
	self = [super init];

	if (self) {
		self.objectMappings = mapping.objectMappings;
		self.metadata = metadata;
	}

	return self;
}


- (SWXMLMapping *) mappingWithMetadata: (SWXMLMetadata *)metadata {
	return [[[self class] alloc] initWithMapping:self andMetadata:metadata];
}

- (NSString*) serializeEnumerator:(NSEnumerator*)enumerator withClassMapping:(SWXMLClassMapping *)classMapping {
	NSMutableArray * lines = [NSMutableArray array];
	
	for (id object in enumerator) {
		[lines addObject:[self serializeObject:object withClassMapping:classMapping]];
	}
	
	return [lines componentsJoinedByString:@"\n"];
}

- (NSString*) serialize: (id)root withTag: (NSString*)tag {
	NSString * serializedString = [self serializeObject:root];
	
	NSString * header = [SWXMLTags tagForXML];
	
	return [header stringByAppendingString:[SWXMLTags tagNamed:tag forValue:serializedString]];
}

- (NSString*) serialize: (id)root {
	NSString *serializedXML = [self serializeObject:root];
	NSString *XMLTag = [SWXMLTags tagForXML];
	
	return [XMLTag stringByAppendingString:serializedXML];
	//[self serialize:root withTag:[self tag]];
}

- (NSString*) serializeObject:(id)object {
	return [self serializeObject:object withClassMapping:nil];
}

- (SWXMLClassMapping *)lookupClassMapping:(id)object
{
	// We need to find the SWXMLClassMapping to serialize this object. The data structure stores Class => ObjectMapping*, so we need to traverse up the class heirarchy to get a more generic mapping object if a specific one does not exist.
	if ([object conformsToProtocol:@protocol(SWXMLMappedClass)]) {
		NSString * mappingName = [object mappedClassName];

		return _objectMappings[mappingName];
	}

	Class objectClass = [object class];

	while (objectClass && objectClass != [NSObject class]) {
		NSString * mappingClassName = [objectClass className];

		// Handle Swift class names in the presence of legacy class names in mapping schemas:
		mappingClassName = [mappingClassName componentsSeparatedByString:@"."].lastObject;

		SWXMLClassMapping * classMapping = _objectMappings[mappingClassName];

		if (classMapping != nil)
			return classMapping;

		objectClass = [objectClass superclass];
	}

	return nil;
}

/* Serializes an arbitraty object to XML */
- (NSString*) serializeObject:(id)object withClassMapping:(SWXMLClassMapping *)classMapping {
	/* Determine the type of object */
	if ([object isKindOfClass:[NSSet class]]) {
		return [self serializeSet:object withClassMapping:classMapping];
	} else if ([object isKindOfClass:[NSArray class]]) {
		return [self serializeArray:object withClassMapping:classMapping];
	}

	if (classMapping == nil)
		classMapping = [self lookupClassMapping:object];

	if (classMapping == nil) {
		NSLog(@"No object mapping for %@", [object class]);
		return nil;
	} else {
		return [classMapping serializeObject:object withMapping:self];
	}
}

- (NSString *)serializeSet:(NSSet *)set withClassMapping:(SWXMLClassMapping *)classMapping {
	return [self serializeEnumerator:set.objectEnumerator withClassMapping:classMapping];
}

- (NSString *)serializeArray:(NSArray *)array withClassMapping:(SWXMLClassMapping *)classMapping {
	return [self serializeEnumerator:array.objectEnumerator withClassMapping:classMapping];
}

@end
