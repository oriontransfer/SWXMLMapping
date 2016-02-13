//
//  SWXMLNumberMapping.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 14/11/05.
//  Copyright 2005 Samuel Williams. All rights reserved.
//

#import "SWXMLNumberMapping.h"
#import "SWXMLMapping.h"

@implementation SWXMLNumberMapping

- serializedObjectMember:(id)object withMapping:(SWXMLMapping*)mapping {
	NSNumberFormatter * numberFormatter = nil;
	NSNumber * number = [object valueForKeyPath:[self keyPath]];

	numberFormatter = [NSNumberFormatter new];
	NSString * currencyCode = (NSString *)mapping.metadata[@"currencyCode"];

	if (currencyCode) {
		numberFormatter.currencyCode = currencyCode;
	}
	
	NSString *format;
	format = [self.attributes valueForKey:@"format"];
	if ([format isEqualToString:@"currency"]) {
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		//[numberFormatter setFormat:@"$#,###.00;0.00;($#,##0.00)"];
	} else if ([format isEqualToString:@"decimal"]) {
		//[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[numberFormatter setFormat:@"###0.00;0;-###0.00"];
	} else if ([format isEqualToString:@"percent"]) {
		[numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
	} else if ([format isEqualToString:@"scientific"]) {
		[numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
	} else if ([format isEqualToString:@"integer"]) {
		[numberFormatter setFormat:@"##"];
	} else if (format != nil) {
		[numberFormatter setFormat:format];
	}
	
	NSString * formattedNumber = [numberFormatter stringFromNumber:number];
	NSDictionary * attributes = @{@"value": [number stringValue]};
	
	return [SWXMLTags tagNamed:self.tag forCDATA:formattedNumber withAttributes:attributes];
}

@end
