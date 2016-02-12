//
//  SWXMLMemberMapping.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLTags.h"

@class SWXMLMapping;

typedef NSDictionary<NSString *, NSString *> NSAttributeDictionary;

@interface SWXMLMemberMapping : NSObject

@property(nonatomic,strong) NSString * tag;
@property(nonatomic,strong) NSString * keyPath;
@property(nonatomic,strong) NSAttributeDictionary * attributes;

// Remap the class name of a given object with this name if specified:
@property(nonatomic,strong) NSString * objectClassName;

- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithTag: (NSString*)tag keyPath: (NSString*)keyPath attributes: (NSAttributeDictionary* )attributes NS_DESIGNATED_INITIALIZER;
- (instancetype) initWithAttributes: (NSDictionary*)attributes;

- (NSString*) serializedObjectMember:(id)object withMapping:(SWXMLMapping*)mapping;

@end
