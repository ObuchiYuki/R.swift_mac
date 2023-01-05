//
//  UIViewController+StoryboardSegueIdentifierProtocol.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 06-12-15.
//  From: https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources

#if canImport(AppKit)
import AppKit

public protocol SeguePerformer {
    func performSegue(withIdentifier identifier: String, sender: Any?)
}

extension NSViewController: SeguePerformer {}

extension SeguePerformer {
    /**
     Initiates the segue with the specified identifier (`R.segue.*`) from the current view controller's storyboard file.
     - parameter identifier: The R.segue.\* that identifies the triggered segue.
     - parameter sender: The object that you want to use to initiate the segue. This object is made available for informational purposes during the actual segue.
     - SeeAlso: Library for typed block based segues: [tomlokhorst/SegueManager](https://github.com/tomlokhorst/SegueManager)
     */
    public func performSegue<Segue, Destination>(withIdentifier identifier: SegueIdentifier<Segue, Self, Destination>, sender: Any?) {
        performSegue(withIdentifier: identifier.identifier, sender: sender)
    }
}

extension SegueIdentifier where Segue: NSStoryboardSegue {
    /// Optionally returns a typed version of the segue.
    /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
    /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
    public func callAsFunction(segue: Segue) -> TypedSegue<Segue, Source, Destination>? {
        TypedSegue(segueIdentifier: self, uiStoryboardSegue: segue)
    }
}

extension SegueIdentifier where Segue: NSStoryboardSegue, Source: NSViewController, Destination: NSViewController {
    /// Trigger a segue by providing a source, destination and handler
    public func perform(source: Source, destination: Destination, handler: @escaping () -> Void) {
        let segue = Segue(identifier: identifier, source: source, destination: destination, performHandler: handler)
        segue.perform()
    }
}

extension TypedSegue {
    /**
     Returns typed information about the given segue, fails if the segue types don't exactly match types.

     - returns: A newly initialized TypedSegue object or nil.
     */
    public init?<StoryboardSegue: NSStoryboardSegue>(segueIdentifier: SegueIdentifier<Segue, Source, Destination>, uiStoryboardSegue: StoryboardSegue) {
        guard
            let identifier = uiStoryboardSegue.identifier,
            let source = uiStoryboardSegue.sourceController as? Source,
            let destination = uiStoryboardSegue.destinationController as? Destination,
            let segue = uiStoryboardSegue as? Segue,
            identifier == segueIdentifier.identifier
        else {
            return nil
        }

        self.init(segue: segue, source: source, destination: destination, identifier: identifier)
    }
}
#endif
