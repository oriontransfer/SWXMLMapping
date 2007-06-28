//
//  SWXMLNumberMapping.m
//  Property Manager
//
//  Created by Sammi Williams on 14/11/05.
//  Copyright 2005 Sammi Williams. All rights reserved.
//

#import "SWXMLNumberMapping.h"


@implementation SWXMLNumberMapping

- serializedObjectMember: (id)object withMapping: (SWXMLMapping*)mapping {
	NSNumberFormatter *numberFormatter;
	NSNumber *num = [object valueForKeyPath:[self keyPath]];

	numberFormatter = [[NSNumberFormatter alloc] init];
	
	NSString *format;
	format = [self->attributes valueForKey:@"format"];
	if ([format isEqualToString:@"currency"]) {
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		//[numberFormatter setFormat:@"$#,###.00;0.00;($#,##0.00)"];
	} else if ([format isEqualToString:@"decimal"])
		[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	else if ([format isEqualToString:@"percent"])
		[numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
	else if ([format isEqualToString:@"scientific"])
		[numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
	else if ([format isEqualToString:@"integer"])
		[numberFormatter setFormat:@"##"];
	else if (format != nil)
		[numberFormatter setFormat:format];
	
	//- (NSString *)descriptionWithCalendarFormat:(NSString *)formatString timeZone:(NSTimeZone *)aTimeZone locale:(NSDictionary *)localeDictionary	

	NSString *formattedNumber = [numberFormatter stringFromNumber:num];
	
	return [SWXMLTags tagNamed:self->tag forCDATA:formattedNumber];
}

@end
