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

+ (SWXMLMapping*) mappingFromURL:(NSURL*)schemaURL {
	SWXMLMappingParser * parser = [[[SWXMLMappingParser alloc] initWithURL:schemaURL] autorelease];
	SWXMLMapping * mapping = [[[SWXMLMapping alloc] init] autorelease];
	
	// ??? root container tag?
	//[mapping setTag:[[parser mappingAttributes] objectForKey:@"tag"]];
	
	mapping.objectMappings = [parser parse];
	
	return mapping;
}

@synthesize objectMappings;

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

/* Serializes an arbitraty object to XML */
- (NSString*) serializeObject:(id)object withClassMapping:(SWXMLClassMapping *)classMapping {
	Class objectClass = [object class];
	
	/* Determine the type of object */
	if ([object isKindOfClass:[NSSet class]])
		return [self serializeSet:object withClassMapping:classMapping];
	else if ([object isKindOfClass:[NSArray class]])
		return [self serializeArray:object withClassMapping:classMapping];
	else if ([object isKindOfClass:[NSDictionary class]])
		return [self serializeDictionary:object withClassMapping:classMapping];
	else {
		// We need to find the SWXMLClassMapping to serialize this object. The data structure stores Class => ObjectMapping*, so we need to traverse up the class heirarchy to get a more generic mapping object if a specific one does not exist.
		
		// A class mapping may have been provided already, otherwise search for an appropriate one:
		if (classMapping == nil) {
			while (objectClass && objectClass != [NSObject class]) {
				classMapping = [self->objectMappings objectForKey:[objectClass className]];
				if (classMapping != nil)
					break;
				else
					objectClass = [objectClass superclass];
			}
		}
		
		if (classMapping == nil) {
			NSLog (@"No object mapping for %@", [object className]);
			return nil;
		}
		
		return [classMapping serializeObject:object withMapping:self];
	}
}

- (NSString *)serializeSet:(NSSet *)set withClassMapping:(SWXMLClassMapping *)classMapping {
	return [self serializeEnumerator:set.objectEnumerator withClassMapping:classMapping];
}

- (NSString *)serializeArray:(NSArray *)array withClassMapping:(SWXMLClassMapping *)classMapping {
	return [self serializeEnumerator:array.objectEnumerator withClassMapping:classMapping];
}

- (NSString*) serializeDictionary: (NSDictionary*)dict withClassMapping:(SWXMLClassMapping *)classMapping {
	return @"";
}
/*
- (NSString*) tag {
	return [[tag retain] autorelease];
}

- (void) setTag: (NSString*)newTag {
	[tag autorelease];
	tag = [newTag retain];
}
*/
@end
