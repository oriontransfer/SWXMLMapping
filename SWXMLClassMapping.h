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

@property(nonatomic,strong) NSString * objectClassName;
@property(nonatomic,strong) NSString * tag;
@property(nonatomic,strong) NSArray * members;
@property(nonatomic,strong) NSDictionary * attributes;

- (instancetype) initWithTag:(NSString*)tag forClass:(NSString*)objectClassName attributes:(NSDictionary *)attributes NS_DESIGNATED_INITIALIZER;

- (NSArray *)membersForObject:(id)object withMapping:(SWXMLMapping *)mapping;
- (NSString *)serializeObject:(id)object withMapping:(SWXMLMapping *)mapping;

@end
