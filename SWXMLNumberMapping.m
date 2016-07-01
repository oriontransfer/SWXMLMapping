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
	NSNumber * number = [object valueForKeyPath:self.keyPath];

	if (number) {
		numberFormatter = [NSNumberFormatter new];
		NSString * currencyCode = (NSString *)mapping.metadata[@"currencyCode"];

		if (currencyCode) {
			numberFormatter.currencyCode = currencyCode;
		}
		
		NSString *format;
		format = [self.attributes valueForKey:@"format"];
		if ([format isEqualToString:@"currency"]) {
			numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
			//[numberFormatter setFormat:@"$#,###.00;0.00;($#,##0.00)"];
		} else if ([format isEqualToString:@"decimal"]) {
			//[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
			numberFormatter.format = @"###0.00;0;-###0.00";
		} else if ([format isEqualToString:@"percent"]) {
			numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
		} else if ([format isEqualToString:@"scientific"]) {
			numberFormatter.numberStyle = NSNumberFormatterScientificStyle;
		} else if ([format isEqualToString:@"integer"]) {
			numberFormatter.format = @"##";
		} else if (format != nil) {
			numberFormatter.format = format;
		}
		
		NSString * formattedNumber = [numberFormatter stringFromNumber:number];
		NSDictionary * attributes = @{@"value": number.stringValue};
		
		return [SWXMLTags tagNamed:self.tag forCDATA:formattedNumber withAttributes:attributes];
	} else {
		return nil;
	}
}

@end
