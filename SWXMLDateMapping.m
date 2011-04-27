//
//  SWXMLDateMapping.m
//  Property Manager
//
//  Created by Samuel Williams on 13/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLDateMapping.h"


@implementation SWXMLDateMapping

- serializedObjectMember: (id)object withMapping: (SWXMLMapping*)mapping {
	NSTimeZone *timezone = nil;
	NSLocale *locale = nil;
	NSDate *date = [object valueForKeyPath:[self keyPath]];
	
	NSString *format;
	format = [self->attributes valueForKey:@"format"];
	
	if (!format)
		format = @"%d-%m-%Y";
	
	NSString *tzName = [self->attributes valueForKey:@"timezone"];
	if (tzName)
		timezone = [[NSTimeZone alloc] initWithName:tzName];
	
	NSString *lcName = [self->attributes valueForKey:@"locale"];
	if (lcName)
		locale = [[NSLocale alloc] initWithLocaleIdentifier:lcName];
	
	/* Even though locale isn't an NSDictionary, it still responds to objectForKey - I suspect this is the intended usage 
		If not, it will probably be a bug and lead to WWIII or something else */
	NSString *formattedDate = [date descriptionWithCalendarFormat:format timeZone:timezone locale:(NSDictionary*)locale];
	
	return [SWXMLTags tagNamed:self->tag forCDATA:formattedDate];
}

@end
