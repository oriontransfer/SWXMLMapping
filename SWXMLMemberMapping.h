//
//  SWXMLMemberMapping.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLTags.h"
#import "SWXMLMapping.h"

@class SWXMLMapping;

@interface SWXMLMemberMapping : NSObject {
	NSString *_tag;
	NSString *_keyPath;
	NSDictionary *_attributes;
}

@property(nonatomic,retain) NSString * tag;
@property(nonatomic,retain) NSString * keyPath;
@property(nonatomic,retain) NSDictionary * attributes;

- initWithTag: (NSString*)tag keyPath: (NSString*)keyPath attributes: (NSDictionary*)attributes;
- initWithAttributes: (NSDictionary*)attributes;

- (NSString*) serializedObjectMember: (id) object withMapping: (SWXMLMapping*)mapping;

@end
