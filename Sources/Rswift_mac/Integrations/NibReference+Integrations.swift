//
//  UINib+NibResource.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 08-01-16.
//

import RswiftResources

#if canImport(AppKit)
import AppKit

extension NibReferenceContainer {

    /**
     Instantiate the nib to get first object from this nib

     - parameter ownerOrNil: The owner, if the owner parameter is nil, connections to File's Owner are not permitted.
     - parameter options: Options are identical to the options specified with` -[NSBundle loadNibNamed:owner:options:]`
     */
    public func callAsFunction(withOwner ownerOrNil: Any?) -> FirstView? {
        var topLevelObjects: NSArray? = nil
        NSNib(nibNamed: name, bundle: bundle)?.instantiate(withOwner: ownerOrNil, topLevelObjects: &topLevelObjects)
        return topLevelObjects?.firstObject as? FirstView
    }

    /**
     Instantiate the nib to get first object from this nib

     - parameter ownerOrNil: The owner, if the owner parameter is nil, connections to File's Owner are not permitted.
     - parameter options: Options are identical to the options specified with` -[NSBundle loadNibNamed:owner:options:]`
     */
    public func firstView(withOwner ownerOrNil: Any?) -> FirstView? {
        var topLevelObjects: NSArray? = nil
        NSNib(nibNamed: name, bundle: bundle)?.instantiate(withOwner: ownerOrNil, topLevelObjects: &topLevelObjects)
        return topLevelObjects?.firstObject as? FirstView
    }

    /**
     Instantiate the nib to get the top-level objects from this nib

     - parameter ownerOrNil: The owner, if the owner parameter is nil, connections to File's Owner are not permitted.
     - parameter options: Options are identical to the options specified with` -[NSBundle loadNibNamed:owner:options:]`

     - returns: An array containing the top-level objects from the NIB
     */
    public func instantiate(withOwner ownerOrNil: Any?) -> [Any] {
        var topLevelObjects: NSArray? = nil
        NSNib(nibNamed: name, bundle: bundle)?.instantiate(withOwner: ownerOrNil, topLevelObjects: &topLevelObjects)
        return topLevelObjects?.map{ $0 } ?? []
    }
}

extension NSNib {
    /**
     Returns a UINib object initialized to the nib file of the specified resource (`R.nib.*`).

     - parameter resource: The resource (`R.nib.*`) to load

     - returns: The initialized UINib object. An exception is thrown if there were errors during initialization or the nib file could not be located.
     */
    public convenience init?<Nib: NibReferenceContainer>(resource: Nib) {
        self.init(nibNamed: resource.name, bundle: resource.bundle)
    }
}

extension NSViewController {
    /**
     Returns a newly initialized view controller with the nib resource (`R.nib.*`).

     - parameter nib: The nib resource (`R.nib.*`) to associate with the view controller.

     - returns: A newly initialized UIViewController object.
     */
    public convenience init<Nib: NibReferenceContainer>(nib: Nib) {
        self.init(nibName: nib.name, bundle: nib.bundle)
    }
}
#endif
