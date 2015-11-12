//
//  SWXSLTransform.h
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 23/02/12.
//  Copyright (c) 2012 Samuel Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWXSLTransform : NSObject {
	NSURL * _baseURL;
	void * _stylesheet;
}

/// The base URL that was used to load the stylesheet:
@property(nonatomic,strong) NSURL * baseURL;

- (instancetype) init NS_UNAVAILABLE;

/// Initialize the XSL stylesheet from the given URL:
- (instancetype) initWithURL:(NSURL *)url NS_DESIGNATED_INITIALIZER;

/// Use the XSL stylesheet to process a string containing XML with a set of arguments.
/// Arguments are typically evaluated by the XSLT processor, so, for example, strings must be passed with an additional set of quotes.
- (NSData *) processDocument:(NSString *)xmlBuffer arguments:(NSDictionary *)arguments;

@end
