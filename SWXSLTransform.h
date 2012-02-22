//
//  SWXSLTransform.h
//  SWXMLMapping
//
//  Created by Samuel Williams on 23/02/12.
//  Copyright (c) 2012 Orion Transfer Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWXSLTransform : NSObject {
	NSURL * _baseURL;
	void * _stylesheet;
}

/// The base URL that was used to load the stylesheet:
@property(nonatomic,retain) NSURL * baseURL;

/// Initialize the XSL stylesheet from the given URL:
- initWithURL:(NSURL *)url;

/// Use the XSL stylesheet to process a string containing XML with a set of arguments.
/// Arguments are typically evaluated by the XSLT processor, so, for example, strings must be passed with an additional set of quotes.
- (NSData *) processDocument:(NSString *)xmlBuffer arguments:(NSDictionary *)arguments;

@end