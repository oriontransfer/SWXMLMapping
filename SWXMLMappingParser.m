//
//  SWXMLMappingParser.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMappingParser.h"

#import "SWXMLNumberMapping.h"
#import "SWXMLBooleanMapping.h"
#import "SWXMLIncludeMapping.h"

@implementation SWXMLMappingParser
+ defaultMemberMappings {
	return @{@"string": [SWXMLStringMapping class],
		@"date": [SWXMLDateMapping class],
		@"collection": [SWXMLCollectionMapping class],
		@"object": [SWXMLMemberMapping class],
		@"number": [SWXMLNumberMapping class],
		@"boolean": [SWXMLBooleanMapping class],
		@"include": [SWXMLIncludeMapping class]};
}

- initWithURL: (NSURL*)loc {
	self = [super init];
	
	if (self) {
		XMLParser = [[NSXMLParser alloc] initWithContentsOfURL:loc];
		[XMLParser setShouldResolveExternalEntities:NO];
		[XMLParser setShouldReportNamespacePrefixes:NO];
		[XMLParser setDelegate:self];
		
		memberMappingClasses = [[self class] defaultMemberMappings];
	}
	
	return self;
}

- initWithData: (NSData*)data {
	self = [super init];
	
	if (self) {
		XMLParser = [[NSXMLParser alloc] initWithData:data];
		[XMLParser setShouldResolveExternalEntities:NO];
		[XMLParser setShouldReportNamespacePrefixes:NO];
		[XMLParser setDelegate:self];

		memberMappingClasses = [[self class] defaultMemberMappings];
	}
	
	return self;
}


- (NSDictionary*) parse {
	@autoreleasepool {
		[XMLParser parse];
	}
	
	return self->objectMappings;
}

- (NSDictionary*) mappingAttributes {
	return mappingAttributes;
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
	//NSLog (@"Parsing...");
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
	//NSLog (@"Finished!");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attr {
	//NSLog ([[@"Begin: " stringByAppendingString:elementName] stringByAppendingFormat:@" (%@ %@ %@)", namespaceURI, qualifiedName, attr]);

	if (objectMapping != nil) {
		Class MemberMapping = memberMappingClasses[elementName];
		if (MemberMapping != nil) {
			[self->memberMappings addObject:[(SWXMLMemberMapping*)[MemberMapping alloc] initWithAttributes:attr]];
		} else {
			NSLog (@"Unknown member type: %@", elementName);
		}
		
		return;
	}

	if ([elementName isEqualToString:@"mapping"]) {
		/* Firstly */
		self->objectMappings = [NSMutableDictionary new];
		self->mappingAttributes = attr;
	} else if ([elementName isEqualToString:@"class"]) {
		/* Set up a new object mapping */
		self->objectMapping = [[SWXMLClassMapping alloc] initWithTag:[attr valueForKey:@"tag"] forClass:[attr valueForKey:@"name"] attributes:attr];
		self->memberMappings = [NSMutableArray new];
	} else {
		NSLog (@"Unknown tag: %@", elementName);
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	//NSLog ([@"End: " stringByAppendingString:elementName]);
	
	if ([elementName isEqualToString:@"mapping"]) {
		/* Lastly */
		return;
	} else if ([elementName isEqualToString:@"class"]) {
		
		[self->objectMapping setMembers:self->memberMappings];
		self->memberMappings = nil;
		
		[self->objectMappings setValue:self->objectMapping forKey:[self->objectMapping objectClassName]];
		self->objectMapping = nil;
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSLog(@"Parse error at line %ld character %ld (%@)", [parser lineNumber], [parser columnNumber], parseError);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)characters {
	NSString * trimmed = [characters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([trimmed length] != 0) {
		NSLog(@"Found characters: %@", trimmed);
	}
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
	//NSLog ([NSString stringWithFormat:@"Comment: %@", comment]);
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	NSLog (@"Found cdata: %@", CDATABlock);
}
@end
