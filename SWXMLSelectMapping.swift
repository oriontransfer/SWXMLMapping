//
//  SWXMLSelectMapping.swift
//  SWXMLMapping
//
//  Created by Samuel Williams on 12/02/16.
//
//

import Foundation

@objc(SWXMLSelection)
public protocol SWXMLSelection {
	init(attributes: [String : String]!, mapping: SWXMLMapping)

	func mapObject(_ object: Any!, withKeyPath keyPath: String!) -> AnyObject!
}

/*
	This mapping allows you to make a selection by instantiating a class which manages the query against a object/keyPath relationship. The result is essentially a collection of items.
	
	<select keyPath="property">
*/
@objc(SWXMLSelectMapping)
open class SWXMLSelectMapping: SWXMLMemberMapping {
	let mappingClass: SWXMLSelection.Type

	override init!(tag: String!, keyPath: String!, attributes: [String : String]!) {
		mappingClass = NSClassFromString(attributes["class"]!) as! SWXMLSelection.Type

		super.init(tag: tag, keyPath: keyPath, attributes: attributes)
	}

	override open func serializedObjectMember(_ object: Any!, with mapping: SWXMLMapping!) -> String! {
		let mappingObject = mappingClass.init(attributes: self.attributes, mapping: mapping)

		let mappedObject = mappingObject.mapObject(object, withKeyPath: self.keyPath)

		return SWXMLTags.tagNamed(self.tag, forValue: mapping.serializeObject(mappedObject))
	}
}
