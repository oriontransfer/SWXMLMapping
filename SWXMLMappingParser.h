//
//  SWXMLMappingParser.h
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SWXMLMapping.h"
#import "SWXMLClassMapping.h"

#import "SWXMLStringMapping.h"
#import "SWXMLDateMapping.h"
#import "SWXMLCollectionMapping.h"

@class SWXMLMapping, SWXMLClassMapping;

@class SWXMLStringMapping, SWXMLDateMapping, SWXMLCollectionMapping, SWXMLNumberMapping, SWXMLBooleanMapping;

@interface SWXMLMappingParser : NSObject {
	/* Root state */
	NSMutableDictionary *objectMappings;
	NSDictionary *mappingAttributes;
	
	/* Object state */
	SWXMLClassMapping *objectMapping;
	NSDictionary *objectAttributes;
	
	/* List of object members */
	NSMutableArray *memberMappings;
	
	NSXMLParser *XMLParser;
	NSDictionary *memberMappingClasses;
	
	//NSURL *XMLURL;
}
- initWithURL: (NSURL*)loc;
- initWithData: (NSData*)data;

+ defaultMemberMappings;

- (NSDictionary*) parse;
- (NSDictionary*) mappingAttributes;

@end
