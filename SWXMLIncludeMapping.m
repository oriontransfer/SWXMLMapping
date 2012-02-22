//
//  SWXMLIncludeMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 22/02/12.
//  Copyright (c) 2012 Samuel Williams. All rights reserved.
//

#import "SWXMLIncludeMapping.h"
#import "SWXMLClassMapping.h"

@implementation SWXMLIncludeMapping

-(NSString *)serializedObjectMember:(id)object withMapping:(SWXMLMapping *)mapping {
	if (self.keyPath) {
		object = [object valueForKeyPath:self.keyPath];
	}
	
	NSString * objectClassName = [self.attributes valueForKey:@"class"];
	SWXMLClassMapping * classMapping = [mapping.objectMappings valueForKey:objectClassName];
	
	if (classMapping) {
		NSArray * children = [classMapping membersForObject:object withMapping:mapping];
		
		if (children.count > 0) {
			return [children componentsJoinedByString:@"\n"];
		}
	}
	
	return nil;
}

@end
