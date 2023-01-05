//
//  StoryboardReference+Integrations.swift
//  R.swift
//
//  Created by Tom Lokhorst on 2022-07-30.
//

import RswiftResources

#if canImport(AppKit)
import AppKit


extension StoryboardReference where Self: InitialControllerContainer {
    /**
     Instantiates and returns the initial controller in the controller graph.

     - returns: The initial controller in the storyboard.
     */
    public func instantiateInitialController() -> InitialController? {
        NSStoryboard(name: name, bundle: bundle).instantiateInitialController() as? InitialController
    }

    /**
     Instantiates and returns the initial view controller in the view controller graph with native dependency injection.

     - parameter creator: The function to inject dependency.

     - returns: The initial view controller in the storyboard.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public func instantiateInitialViewController(creator: @escaping (NSCoder) -> InitialController?) -> InitialController? where InitialController: NSViewController {
        NSStoryboard(name: name, bundle: bundle).instantiateInitialController(creator: creator)
    }
    
    /**
     Instantiates and returns the initial window controller in the window controller graph with native dependency injection.

     - parameter creator: The function to inject dependency.

     - returns: The initial window controller in the storyboard.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public func instantiateInitialWindowController(creator: @escaping (NSCoder) -> InitialController?) -> InitialController? where InitialController: NSWindowController {
        NSStoryboard(name: name, bundle: bundle).instantiateInitialController(creator: creator)
    }
}

extension StoryboardViewControllerIdentifier {
    /**
     Instantiates and returns the view controller with the specified resource (`R.storyboard.*.*`).

     - returns: The view controller corresponding to the specified resource (`R.storyboard.*.*`). If no view controller is associated, this method throws an exception.
     */
    public func callAsFunction() -> ViewController? {
        NSStoryboard(name: storyboard, bundle: bundle).instantiateController(withIdentifier: identifier) as? ViewController
    }


    /**
     Instantiates and returns the view controller with the specified resource (`R.storyboard.*.*`) and native dependency injection.

     - parameter creator: The function to inject dependency.

     - returns: The view controller corresponding to the specified resource (`R.storyboard.*.*`).
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public func callAsFunction(creator: @escaping (NSCoder) -> ViewController?) -> ViewController? where ViewController: NSViewController {
        NSStoryboard(name: storyboard, bundle: bundle).instantiateController(identifier: identifier, creator: creator)
    }
    
    /**
     Instantiates and returns the view controller with the specified resource (`R.storyboard.*.*`) and native dependency injection.

     - parameter creator: The function to inject dependency.

     - returns: The view controller corresponding to the specified resource (`R.storyboard.*.*`).
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public func callAsFunction(creator: @escaping (NSCoder) -> ViewController?) -> ViewController? where ViewController: NSWindowController {
        NSStoryboard(name: storyboard, bundle: bundle).instantiateController(identifier: identifier, creator: creator)
    }
}

extension NSStoryboard {
    /**
     Creates and returns a storyboard object for the specified storyboard resource (`R.storyboard.*`) file.

     - parameter resource: The storyboard resource (`R.storyboard.*`) for the specific storyboard to load

     - returns: A storyboard object for the specified file. If no storyboard resource file matching name exists, an exception is thrown with description: `Could not find a storyboard named 'XXXXXX' in bundle....`
     */
    public convenience init<Reference: StoryboardReference>(resource: Reference) {
        self.init(name: resource.name, bundle: resource.bundle)
    }


    /**
     Instantiates and returns the view controller with the specified resource (`R.storyboard.*.*`).

     - parameter resource: An resource (`R.storyboard.*.*`) that uniquely identifies the view controller in the storyboard file. If the specified resource does not exist in the storyboard file, this method raises an exception.

     - returns: The view controller corresponding to the specified resource (`R.storyboard.*.*`). If no view controller is associated, this method throws an exception.
     */
    public func instantiateViewController<ViewController: NSViewController>(withIdentifier identifier: StoryboardViewControllerIdentifier<ViewController>) -> ViewController?  {
        self.instantiateController(withIdentifier: identifier.identifier) as? ViewController
    }
    
    /**
     Instantiates and returns the window controller with the specified resource (`R.storyboard.*.*`).

     - parameter resource: An resource (`R.storyboard.*.*`) that uniquely identifies the window controller in the storyboard file. If the specified resource does not exist in the storyboard file, this method raises an exception.

     - returns: The window controller corresponding to the specified resource (`R.storyboard.*.*`). If no window controller is associated, this method throws an exception.
     */
    public func instantiateWindowController<WindowController: NSWindowController>(withIdentifier identifier: StoryboardViewControllerIdentifier<WindowController>) -> WindowController?  {
        self.instantiateController(withIdentifier: identifier.identifier) as? WindowController
    }
}
#endif
