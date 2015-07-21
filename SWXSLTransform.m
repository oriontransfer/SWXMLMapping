//
//  SWXSLTransform.m
//  This file is part of the "SWXMLMapping" project, and is distributed under the MIT License.
//
//  Created by Samuel Williams on 23/02/12.
//  Copyright (c) 2012 Samuel Williams. All rights reserved.
//

#import "SWXSLTransform.h"

#include <libxslt/xslt.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>
#include <libexslt/exslt.h>

@implementation SWXSLTransform

+ (void)initialize {
	// Ensure that entities are substituted correctly:
	xmlSubstituteEntitiesDefault(1);
	
	// Ensure that external entity subsets are loaded:
	xmlLoadExtDtdDefaultValue = 1;
	
	// Register all supported external modules:
	exsltRegisterAll();
	
	// Register xslt test modules (???)
	//xsltRegisterTestModule();
}

@synthesize baseURL = _baseURL;

- (void) releaseStylesheet {
	if (_stylesheet) {
		xsltFreeStylesheet((xsltStylesheetPtr)_stylesheet);
		_stylesheet = NULL;
	}	
}

- (void) loadStylesheetFromURL:(NSURL *)stylesheetURL {
	[self releaseStylesheet];
	
	if (stylesheetURL) {
		NSAssert(stylesheetURL.isFileURL, @"Stylesheet URL was not a local file!");
		
		const char * localPath = [stylesheetURL.path UTF8String];
		_stylesheet = xsltParseStylesheetFile((const xmlChar *)localPath);
		
		if (_stylesheet == NULL) {
			NSLog(@"Could not load stylesheet: %@", stylesheetURL);
		}
	}
}

- (instancetype)initWithURL:(NSURL *)url {
	self = [super init];
	
	if (self) {
		self.baseURL = url;
		[self loadStylesheetFromURL:url];
	}
	
	return self;
}

- (void)dealloc
{
	[self releaseStylesheet];
	
}

- (NSData *) processDocument:(NSString *)xmlBuffer arguments:(NSDictionary *)arguments {
	NSAssert(_stylesheet != NULL, @"Stylesheet is NULL");
	
	const char ** parameters = (const char **)malloc(2 * sizeof(const char *) * (arguments.count + 1));
	
	NSUInteger parameterOffset = 0;
	for (NSString * key in arguments) {
		parameters[parameterOffset] = [key UTF8String];
		parameters[parameterOffset+1] = [(NSString *)arguments[key] UTF8String];
		
		parameterOffset += 2;
	}
	
	parameters[parameterOffset] = NULL;
		
	xmlDocPtr sourceDocument = xmlParseMemory([xmlBuffer UTF8String], [xmlBuffer lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	
	xmlDocPtr processedDocument = xsltApplyStylesheet((xsltStylesheetPtr)_stylesheet, sourceDocument, parameters);
	
	xmlOutputBufferPtr outputBuffer = xmlAllocOutputBuffer(NULL);
	
	xsltSaveResultTo(outputBuffer, processedDocument, (xsltStylesheetPtr)_stylesheet);

	const xmlChar * contents = xmlOutputBufferGetContent(outputBuffer);
	size_t size = xmlOutputBufferGetSize(outputBuffer);

	NSData * result = [[NSData alloc] initWithBytes:contents length:size];
	
	xmlOutputBufferClose(outputBuffer);
	xmlFreeDoc(sourceDocument);
	xmlFreeDoc(processedDocument);
	
	free(parameters);
	
	return result;
}

@end
