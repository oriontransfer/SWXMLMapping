//
//  SWXMLClassMapping.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMapping.h"
#import "SWXMLMemberMapping.h"

@class SWXMLMapping, SWXMLMemberMapping;

@interface SWXMLClassMapping : NSObject {
	NSString * _objectClassName;
	NSString * _tag;
	
	// List of tags (SWXMLMemberMapping)
	NSArray * _members;
	
	NSDictionary * _attributes;

}

@property(nonatomic,retain) NSString * objectClassName;
@property(nonatomic,retain) NSString * tag;
@property(nonatomic,retain) NSArray * members;
@property(nonatomic,retain) NSDictionary * attributes;

- initWithTag:(NSString*)tag forClass:(NSString*)objectClassName attributes:(NSDictionary *)attributes;

- (NSArray *)membersForObject:(id)object withMapping:(SWXMLMapping *)mapping;
- (NSString *)serializeObject:(id)object withMapping:(SWXMLMapping *)mapping;

@end
