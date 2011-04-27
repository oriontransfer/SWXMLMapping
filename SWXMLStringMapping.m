//
//  SWXMLStringMapping.m
//  Property Manager
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLStringMapping.h"


@implementation SWXMLStringMapping

- (NSString*) serializedObjectMember: (id) object withMapping: (SWXMLMapping*)mapping {
	return [SWXMLTags tagNamed:self->tag forCDATA:[object valueForKeyPath:self->keyPath]];
}

@end
