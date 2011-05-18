//
//  SWXMLBooleanMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 14/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLBooleanMapping.h"


@implementation SWXMLBooleanMapping

- serializedObjectMember: (id)object withMapping: (SWXMLMapping*)mapping {
	NSString *trueString = @"true", *falseString = @"false";
	NSString *result;
	
	id obj = [object valueForKeyPath:[self keyPath]];
	if (obj == nil)
		result = falseString;
	else if ([obj isKindOfClass:[NSNumber class]]) {
		if ([obj boolValue])
			result = trueString;
		else
			result = falseString;
	} else
		result = falseString;
	
	return [SWXMLTags tagNamed:self->tag forCDATA:result];
}

@end
