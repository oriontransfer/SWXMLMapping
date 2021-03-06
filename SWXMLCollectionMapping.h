//
//  SWXMLCollectionMapping.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLMemberMapping.h"

@class SWXMLMemberMapping;

@interface SWXMLCollectionMapping : SWXMLMemberMapping

// Select only specific objects that match the given class name if specified:
@property(nonatomic,strong) NSString * filterClassName;

// How to sort the collection:
@property(nonatomic,strong) NSArray * sortDescriptors;

@end
