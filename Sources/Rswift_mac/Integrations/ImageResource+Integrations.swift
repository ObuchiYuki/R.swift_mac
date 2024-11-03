//
//  UIImage+ImageResource.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 11-01-16.
//

import Foundation
import SwiftUI
import RswiftResources

#if canImport(AppKit)
import AppKit

extension RswiftResources.ImageResource {

    /**
     Returns the image from this resource (`R.image.*`) that is compatible with the trait collection.

     - parameter resource: The resource you want the image of (`R.image.*`)
     - parameter traitCollection: Traits that describe the desired image to retrieve, pass nil to use traits that describe the main screen.

     - returns: An image that exactly or best matches the desired traits with the given resource (`R.image.*`), or nil if no suitable image was found.
     */
    //    @available(*, deprecated, message: "Use UIImage(resource:) initializer instead")
    public func callAsFunction() -> NSImage! {
        bundle.image(forResource: name)
    }
}

extension NSImage {

    /**
     Returns the image from this resource (`R.image.*`) that is compatible with the trait collection.

     - parameter resource: The resource you want the image of (`R.image.*`)
     - parameter traitCollection: Traits that describe the desired image to retrieve, pass nil to use traits that describe the main screen.

     - returns: An image that exactly or best matches the desired traits with the given resource (`R.image.*`), or nil if no suitable image was found.
     */
    public convenience init!(resource: RswiftResources.ImageResource) {
        guard let url = resource.bundle.urlForImageResource(resource.name) else { return nil }
        self.init(contentsOf: url)
    }
}
#endif
