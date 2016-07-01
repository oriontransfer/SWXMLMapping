//
//  SWXMLDateMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLDateMapping.h"


@implementation SWXMLDateMapping

// ISO8601
- (NSString *) standardDateString: (NSDate *)date {
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
	dateFormatter.locale = enUSPOSIXLocale;
	dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";

	return [dateFormatter stringFromDate:date];
}

- serializedObjectMember: (id)object withMapping: (SWXMLMapping*)mapping {
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	NSTimeZone *timezone = nil;
	NSLocale *locale = nil;
	NSDate *date = [object valueForKeyPath:self.keyPath];

	if (date) {
		NSString *format;
		format = [self.attributes valueForKey:@"format"];
		
		if (!format)
			format = @"yyyy-MM-dd";

		dateFormatter.dateFormat = format;
		
		NSString *timezoneName = [self.attributes valueForKey:@"timezone"];
		if (timezoneName)
			dateFormatter.timeZone = [NSTimeZone timeZoneWithName:timezoneName];
		
		NSString *localeName = [self.attributes valueForKey:@"locale"];
		if (localeName)
			dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:localeName];

		return [SWXMLTags tagNamed:self.tag forCDATA:[dateFormatter stringFromDate:date] withAttributes:@{
			@"value": [self standardDateString:date]
		}];
	} else {
		return nil;
	}
}

@end
