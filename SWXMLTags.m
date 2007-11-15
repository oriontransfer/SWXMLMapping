//
//  SWXMLTags.m
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import "SWXMLTags.h"
#import "SWApplicationSupport/NSString+EscapingAdditions.h"
#import "SWApplicationSupport/NSString+SplitIntoLines.h"

@interface SWXMLTags (Private)
+ (NSString*) indent: (NSString*)inner;
@end

@implementation SWXMLTags
+ (NSString*) tagForXML {
	return @"<?xml version=\"1.0\"?>\n";
}

+ (NSDictionary*)substitutions {
	return [NSDictionary dictionaryWithObjectsAndKeys:
		@"&gt;", @">", @"&lt;", @"<", @"&amp;", @"&", nil];
}

+ (NSString*) tagNamed: (NSString*)name {
	return [NSString stringWithFormat:@"<%@ />", name];
}

+ (NSString*) tagNamed: (NSString*)name forCDATA: (NSString*)value {
	if (value == nil) value = @"";
	return [NSString stringWithFormat:@"<%@>%@</%@>", name, [value substitute:[self substitutions]], name];
}

+ (NSString*) tagNamed: (NSString*)name forValue: (NSString*)value {
	if (value == nil) value = @"";
	return [NSString stringWithFormat:@"<%@>\n%@</%@>", name, [self indent:value], name];
}

+ (NSString*) indent: (NSString*)inner {
	NSArray *lines = [inner componentsSeparatedByLineBreaks];
	NSMutableString *res = [[NSMutableString alloc] init];
	id o, i = [lines objectEnumerator];
	
	while ((o = [i nextObject]) != nil) {
		if (o == nil) continue;
		
		[res appendFormat:@"\t%@\n", o];
	}
	
	return [res autorelease];
}

+ (NSString*) formatAttributes: (NSDictionary*)attributes {
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

+ (NSString*) tagNamed: (NSString*)name withAttributes: (NSDictionary*)attributes {
	return [NSString stringWithFormat:@"<%@%@ />", name, [self formatAttributes:attributes]];
}

@end
