//
//  SWXMLCollectionMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLCollectionMapping.h"


@implementation SWXMLCollectionMapping

- serializedObjectMember: (id)object withMapping: (SWXMLMapping*)mapping {
	NSString* collection = [mapping serializeObject:[object valueForKeyPath:[self keyPath]]];

	//NSLog (@"SWXMLCollectionMapping: %@", mapping);
	//NSLog (@"SWXMLCollectionMapping: %@", collection);

	return [SWXMLTags tagNamed:[self tag] forValue:collection];
}

@end
