//
//  UITableView+ReuseIdentifierProtocol.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 06-12-15.
//  From: https://github.com/mac-cain13/R.swift
//

import RswiftResources

#if canImport(AppKit)
import AppKit

extension NSTableView {

    /**
     Register a `R.nib.*` containing a cell with the table view under it's contained identifier.

     - parameter resource: A nib resource (`R.nib.*`) containing a table view cell that has a reuse identifier
     */
    public func register<Resource: NibReferenceContainer & ReuseIdentifierContainer>(_ resource: Resource) where Resource.Reusable: NSView {
        self.register(NSNib(resource: resource), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: resource.identifier))
    }

    /**
     Returns a typed reusable table-view cell object for the specified reuse identifier and adds it to the table.

     - parameter identifier: A `R.reuseIdentifier.*` value identifying the cell object to be reused.
     - parameter indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the table view.

     - returns: The UITableViewCell subclass with the associated reuse identifier or nil if it couldn't be casted correctly.

     - precondition: You must register a class or nib file using the registerNib: or registerClass:forCellReuseIdentifier: method before calling this method.
     */
    public func dequeueReusableCell<Identifier: ReuseIdentifierContainer>(withIdentifier identifier: Identifier) -> Identifier.Reusable! where Identifier.Reusable: NSView {
        self.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier.identifier), owner: self) as? Identifier.Reusable
    }
}

#endif
