//
//  SWXMLMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMapping.h"
//Private
#import "SWXMLMappingParser.h"

@interface SWXMLMapping (Private)
- (NSString*) serializeEnumerator: (NSEnumerator*)i;
@end

@implementation SWXMLMapping
+ (SWXMLMapping*) mappingFromURL: (NSURL*)loc {
	SWXMLMappingParser *parser = [[[SWXMLMappingParser alloc] initWithURL:loc] autorelease];
	SWXMLMapping *mapping = [[[SWXMLMapping alloc] init] autorelease];
	NSDictionary *objectMappings;
	
	objectMappings = [parser parse];
	
	[mapping setObjectMappings:objectMappings];
	//[mapping setTag:[[parser mappingAttributes] objectForKey:@"tag"]];
	
	return mapping;
}

- (void) setObjectMappings: (NSDictionary*)newObjectMappings {
	[self->objectMappings autorelease];
	self->objectMappings = [newObjectMappings retain];
}

- (NSDictionary*) objectMappings {
	return [[self->objectMappings retain] autorelease];
}

- (NSString*) serializeEnumerator: (NSEnumerator*)i {
	id obj;
	NSMutableString *str = [[NSMutableString new] autorelease];
	
	while ((obj = [i nextObject]) != nil) {
		[str appendFormat:@"%@\n", [self serializeObject:obj]];
	}
	
	return str;
}
/*
- (NSString*) serialize: (id)root withTag: (NSString*)tag {
	NSString *serializedString = [self serializeObject:root];
	
	return [SWXMLTags tagNamed:tag forValue:serializedString];
}
*/
- (NSString*) serialize: (id)root {
	NSString *serializedXML = [self serializeObject:root];
	NSString *XMLTag = [SWXMLTags tagForXML];
	
	return [XMLTag stringByAppendingString:serializedXML];
	//[self serialize:root withTag:[self tag]];
}

/* Serializes an arbitraty object to XML */
- (NSString*) serializeObject: (id)object {
	Class objectClass = [object class];
	/* Determine the type of object */
	if ([object isKindOfClass:[NSSet class]])
		return [self serializeSet:object];
	else if ([object isKindOfClass:[NSArray class]])
		return [self serializeArray:object];
	else if ([object isKindOfClass:[NSDictionary class]])
		return [self serializeDictionary:object];
	else {
		/* We need to find the SWXMLClassMapping to serialize this object
		   The data structure stores Class => ObjectMapping*, so we need to
		   traverse up the class heirarchy to get a more generic mapping object
		   if a specific one does not exist */
		SWXMLClassMapping *objectMapping = nil;
		while (objectClass && objectClass != [NSObject class]) {
			objectMapping = [self->objectMappings objectForKey:[objectClass className]];
			if (objectMapping != nil)
				break;
			else
				objectClass = [objectClass superclass];
		}
		
		if (objectMapping == nil) {
			NSLog (@"No object mapping for %@", [object className]);
			return nil;
		}
		
		return [objectMapping serializeObject: object withMapping:self];
	}
}

- (NSString*) serializeSet: (NSSet*)set {
	return [self serializeEnumerator:[set objectEnumerator]];
}

- (NSString*) serializeArray: (NSArray*)arr {
	return [self serializeObject:[arr objectEnumerator]];
}

- (NSString*) serializeDictionary: (NSDictionary*)dict {
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
