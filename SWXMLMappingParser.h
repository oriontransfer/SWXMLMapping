//
//  SWXMLMappingParser.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMapping.h"
#import "SWXMLClassMapping.h"

#import "SWXMLStringMapping.h"
#import "SWXMLDateMapping.h"
#import "SWXMLCollectionMapping.h"

@class SWXMLMapping, SWXMLClassMapping;

@class SWXMLStringMapping, SWXMLDateMapping, SWXMLCollectionMapping, SWXMLNumberMapping, SWXMLBooleanMapping;

@interface SWXMLMappingParser : NSObject <NSXMLParserDelegate> {
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
