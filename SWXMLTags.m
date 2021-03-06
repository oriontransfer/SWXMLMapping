//
//  SWXMLTags.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLTags.h"

@interface SWXMLTags (Private)
+ (NSString*) indent: (NSString*)inner;
+ (NSString*) substitute: (NSDictionary*)replacements inString: (NSString*)string;
@end

@implementation SWXMLTags
+ (NSString*) tagForXML {
	return @"<?xml version=\"1.0\"?>\n";
}

+ (NSString*)encodeBasicXMLEntities:(NSString*)string {
	NSMutableString * result = [string mutableCopy];
	
	[result replaceOccurrencesOfString:@"&"	withString:@"&amp;" options:0 range:NSMakeRange(0, result.length)];
	[result replaceOccurrencesOfString:@"<"	withString:@"&lt;" options:0 range:NSMakeRange(0, result.length)];
	[result replaceOccurrencesOfString:@">"	withString:@"&gt;" options:0 range:NSMakeRange(0, result.length)];
	
	return result;
}

+ (NSString*) tagNamed: (NSString*)name {
	return [NSString stringWithFormat:@"<%@ />", name];
}

+ (NSString*) tagNamed: (NSString*)name forCDATA: (NSString*)value {
	if (value == nil) value = @"";
	
	NSString * inner = [self encodeBasicXMLEntities:value];
	
	return [NSString stringWithFormat:@"<%@>%@</%@>", name, inner, name];
}

+ (NSString*) tagNamed: (NSString*)name forValue: (NSString*)value {
	if (value == nil) value = @"";
	return [NSString stringWithFormat:@"<%@>\n%@</%@>", name, [self indent:value], name];
}

+ (NSString*) indent: (NSString*)inner {
	// Avoid adding newlines to empty space.
	if (inner.length == 0)
		return @"";
	
	NSCharacterSet * lineEndings = [NSCharacterSet characterSetWithCharactersInString:@"\r\n"];
	NSArray * lines = [inner componentsSeparatedByCharactersInSet:lineEndings];
	NSMutableString * buffer = [NSMutableString string];
	
	for (NSString * line in lines) {
		[buffer appendFormat:@"\t%@\n", line];
	}
	
	return buffer;
}

+ (NSString*) formatAttributes: (NSDictionary*)attributes {
	if (attributes == nil) return @"";
	
	id o, i = [attributes keyEnumerator];
	NSMutableString *attrString = [NSMutableString new];
	
	while ((o = [i nextObject]) !=nil) {
		[attrString appendFormat:@" %@=\"%@\"", o, [attributes valueForKey:o]];
	}
	
	return attrString;
}

+ (NSString*) tagNamed: (NSString*)name forValue: (NSString*)value withAttributes: (NSDictionary*)attributes {
	if (value == nil) value = @"";
	return [NSString stringWithFormat:@"<%@%@>\n%@</%@>", name, [self formatAttributes:attributes], [self indent:value], name];
}

+ (NSString*) tagNamed: (NSString*)name forCDATA: (NSString*)value withAttributes: (NSDictionary*)attributes {
	if (value == nil) value = @"";

	NSString * inner = [self encodeBasicXMLEntities:value];

	return [NSString stringWithFormat:@"<%@%@>%@</%@>", name, [self formatAttributes:attributes], inner, name];
}

+ (NSString*) tagNamed: (NSString*)name withAttributes: (NSDictionary*)attributes {
	return [NSString stringWithFormat:@"<%@%@ />", name, [self formatAttributes:attributes]];
}

@end
