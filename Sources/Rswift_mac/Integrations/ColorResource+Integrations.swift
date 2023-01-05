//
//  UIColor+ColorResource.swift
//  R.swift
//
//  Created by Tom Lokhorst on 2017-06-06.
//

import Foundation
import RswiftResources

#if canImport(AppKit)
import AppKit

extension ColorResource {

    /**
     Returns the color from this resource (`R.color.*`) that is compatible with the trait collection.

     - parameter resource: The resource you want the color of (`R.color.*`)
     - parameter traitCollection: Traits that describe the desired color to retrieve, pass nil to use traits that describe the main screen.

     - returns: A color that exactly or best matches the desired traits with the given resource (`R.color.*`), or nil if no suitable color was found.
     */
    //    @available(*, deprecated, message: "Use UIColor(resource:) initializer instead")
    public func callAsFunction() -> NSColor! {
        NSColor(named: name, bundle: bundle)
    }
}

extension NSColor {

    /**
     Returns the color from this resource (`R.color.*`) that is compatible with the trait collection.

     - parameter resource: The resource you want the color of (`R.color.*`)
     - parameter traitCollection: Traits that describe the desired color to retrieve, pass nil to use traits that describe the main screen.

     - returns: A color that exactly or best matches the desired traits with the given resource (`R.color.*`), or nil if no suitable color was found.
     */
    public convenience init!(resource: ColorResource) {
        self.init(named: resource.name, bundle: resource.bundle)!
    }

}
#endif
