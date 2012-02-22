//
//  SWXSLTransform.m
//  SWXMLMapping
//
//  Created by Samuel Williams on 23/02/12.
//  Copyright (c) 2012 Orion Transfer Ltd. All rights reserved.
//

#import "SWXSLTransform.h"

#include <libxml/xmlmemory.h>
#include <libxml/debugXML.h>
#include <libxml/HTMLtree.h>
#include <libxml/xmlIO.h>
#include <libxml/DOCBparser.h>
#include <libxml/xinclude.h>
#include <libxml/catalog.h>
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>

// extern int xmlLoadExtDtdDefaultValue;

@implementation SWXSLTransform

@synthesize baseURL = _baseURL;

+ (void)initialize {
	// xmlSubstituteEntitiesDefault(1);
	// xmlLoadExtDtdDefaultValue = 1;
}

- (void) releaseStylesheet {
	if (_stylesheet) {
		xsltFreeStylesheet((xsltStylesheetPtr)_stylesheet);
	}	
}

- (void) loadStylesheetFromURL:(NSURL *)stylesheetURL {
	[self releaseStylesheet];
	
	if (stylesheetURL) {
		NSAssert(stylesheetURL.isFileURL, @"Stylesheet URL was not a local file!");
		
		const char * localPath = [stylesheetURL.path UTF8String];
		_stylesheet = xsltParseStylesheetFile((const xmlChar *)localPath);
	}
}

- (id)initWithURL:(NSURL *)url {
	self = [super init];
	
	if (self) {
		self.baseURL = url;
		[self loadStylesheetFromURL:url];
	}
	
	return self;
}

- (void)dealloc
{
	self.baseURL = nil;
	[self releaseStylesheet];
	
    [super dealloc];
}

- (NSData *) processDocument:(NSString *)xmlBuffer arguments:(NSDictionary *)arguments {
	const char ** parameters = (const char **)malloc(2 * sizeof(const char *) * (arguments.count + 1));
	
	NSUInteger parameterOffset = 0;
	for (NSString * key in arguments) {
		parameters[parameterOffset] = [key UTF8String];
		parameters[parameterOffset+1] = [(NSString *)[arguments objectForKey:key] UTF8String];
		
		parameterOffset += 2;
	}
	
	parameters[parameterOffset] = NULL;
		
	xmlDocPtr sourceDocument = xmlParseMemory([xmlBuffer UTF8String], [xmlBuffer lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	
	xmlDocPtr processedDocument = xsltApplyStylesheet((xsltStylesheetPtr)_stylesheet, sourceDocument, parameters);
	
	xmlOutputBufferPtr outputBuffer = xmlAllocOutputBuffer(NULL);
	
	xsltSaveResultTo(outputBuffer, processedDocument, (xsltStylesheetPtr)_stylesheet);
	
	NSData * result = [[NSData alloc] initWithBytes:outputBuffer->buffer->content length:outputBuffer->buffer->use];
	
	xmlOutputBufferClose(outputBuffer);
	xmlFreeDoc(sourceDocument);
	xmlFreeDoc(processedDocument);
	
	free(parameters);
	
	return result;
}

@end
