//
//  SWXMLMapping.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@class SWXMLClassMapping;

typedef NSDictionary<NSString *, NSObject *> SWXMLMetadata;

@interface SWXMLMapping : NSObject

@property(nonatomic,strong) NSDictionary * objectMappings;
@property(nonatomic,strong) SWXMLMetadata * metadata;

+ (SWXMLMapping *) mappingFromURL:(NSURL *)schemaURL;

- (instancetype) init NS_DESIGNATED_INITIALIZER;
- (instancetype) initWithMapping:(SWXMLMapping *)mapping andMetadata:(SWXMLMetadata *)metadata NS_DESIGNATED_INITIALIZER;
- (SWXMLMapping *) mappingWithMetadata: (SWXMLMetadata *)metadata;

// Includes <?xml ... ?>
- (NSString*) serialize:(id)root;
- (NSString*) serialize:(id)root withTag:(NSString*)tag;

- (NSString*) serializeObject:(id)object;
- (NSString*) serializeObject:(id)object withClassMapping:(SWXMLClassMapping *)classMapping;

- (NSString*) serializeEnumerator:(NSEnumerator*)enumerator withClassMapping:(SWXMLClassMapping*)classMapping;
- (NSString*) serializeSet:(NSSet*)set withClassMapping:(SWXMLClassMapping *)classMapping;
- (NSString*) serializeArray:(NSArray*)array withClassMapping:(SWXMLClassMapping *)classMapping;

@end

#import "SWXMLMemberMapping.h"
#import "SWXSLTransform.h"
#import "SWXMLStringMapping.h"
#import "SWXMLNumberMapping.h"
#import "SWXMLMappingParser.h"
#import "SWXMLDateMapping.h"
#import "SWXMLClassMapping.h"
#import "SWXMLBooleanMapping.h"
#import "SWXMLIncludeMapping.h"
#import "SWXMLCollectionMapping.h"
