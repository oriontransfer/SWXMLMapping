//
//  SWXMLTags.h
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

/*
	This is used for generating basic XML tags from strings.
*/

#import <Cocoa/Cocoa.h>


@interface SWXMLTags : NSObject {

}
// returns <?xml ... ?> tag for use with the output of these tags at the head of a file.
+ (NSString*) tagForXML;

+ (NSString*) tagNamed: (NSString*)name;
+ (NSString*) tagNamed: (NSString*)name forValue: (NSString*)value;
+ (NSString*) tagNamed: (NSString*)name forCDATA: (NSString*)value;

/* Returns a string of key="value" */
+ (NSString*) formatAttributes: (NSDictionary*)attributes;

+ (NSString*) tagNamed: (NSString*)name forValue: (NSString*)value withAttributes: (NSDictionary*)attributes;

@end
