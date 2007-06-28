//
//  SWXMLMapping.h
//  Property Manager
//
//  Created by Sammi Williams on 13/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
<?xml version="1.0"?>
<mapping tag="transactions">
	<object class="PMProperty" tag="property">
		<string class="NSString" tag="name" keyPath="name" />
		<set tag="tenures" keyPath="tenures" />
	</object>
	
	<object class="PMTenure" tag="tenure">
		<date tag="startDate" keyPath="startDate" format="DD-MM-YYYY" />
		<date tag="endDate keyPath="endDate" format="DD-MM-YYYY" />
		<number tag="amount" keyPath="amount" format="$%%.%%" />
	</object>
	
	<object class="PMTenant" tag="tenant">
		
	</object>
	
	<object class="PMTransaction" tag="transaction">
		<member name="amount" keyPath="amount" />
		<member name="property" keyPath="property.name" />
		<constant tag="type" value="
	</object>
</mapping>

*/

@interface SWXMLMapping : NSObject {
	NSDictionary *objectMappings;
}

+ (SWXMLMapping*) mappingFromURL: (NSURL*)loc;

- (NSString*) serializeObject: (id)object;
- (NSString*) serializeSet: (NSSet*)set;
- (NSString*) serializeArray: (NSArray*)arr;
- (NSString*) serializeDictionary: (NSDictionary*)dict;

- (void) setObjectMappings: (NSDictionary*)objectMappings;
- (NSDictionary*) objectMappings;

//- (NSString*) tag;
//- (void) setTag: (NSString*)newTag;
@end
