@_exported import SwiftUINavigation

#if canImport(UIKitNavigation)
@_exported import UIKitNavigation
#elseif canImport(AppKitNavigation)
@_exported import AppKitNavigation
#endif

import SwiftUI

/// Executes a closure with the specified animation and returns the result.
///
/// - Parameters:
///   - animation: An animation, set in the ``UITransaction/uiKit`` property of the thread's
///     current transaction.
///   - body: A closure to execute.
///   - completion: A completion to run when the animation is complete.
/// - Returns: The result of executing the closure with the specified animation.
@MainActor
@inlinable
public func withSwiftUIAnimation<Result>(
	_ animation: Animation? = .default,
	_ body: () throws -> Result,
	completion: (@MainActor @Sendable (Bool?) -> Void)? = nil
) rethrows -> Result {
	try withCocoaAnimation(
		animation.map(CocoaAnimation.init),
		{ try withAnimation(animation, body) },
		completion: completion.map { completion in
			return { @Sendable (result: Bool?) -> Void in
				MainActor.assumeIsolated { completion(result) }
			}
		}
	)
}

#if canImport(UIKitNavigation)

public typealias CocoaAnimation = UIKitAnimation

/// Executes a closure with the specified animation and returns the result.
///
/// - Parameters:
///   - animation: An animation, set in the ``UITransaction/uiKit`` property of the thread's
///     current transaction.
///   - body: A closure to execute.
///   - completion: A completion to run when the animation is complete.
/// - Returns: The result of executing the closure with the specified animation.
@MainActor
@inlinable
public func withCocoaAnimation<Result>(
	_ animation: CocoaAnimation? = .default,
	_ body: () throws -> Result,
	completion: (@MainActor @Sendable (Bool?) -> Void)? = nil
) rethrows -> Result {
	try withUIKitAnimation(
		animation,
		body,
		completion: completion.map { completion in
			return { @Sendable (result: Bool?) -> Void in
				MainActor.assumeIsolated { completion(result) }
			}
		}
	)
}

#elseif canImport(AppKitNavigation)

public typealias CocoaAnimation = AppKitAnimation

/// Executes a closure with the specified animation and returns the result.
///
/// - Parameters:
///   - animation: An animation, set in the ``UITransaction/appKit`` property of the thread's
///     current transaction.
///   - body: A closure to execute.
///   - completion: A completion to run when the animation is complete.
/// - Returns: The result of executing the closure with the specified animation.
@MainActor
@inlinable
public func withCocoaAnimation<Result>(
	_ animation: CocoaAnimation? = .default,
	_ body: () throws -> Result,
	completion: (@Sendable (Bool?) -> Void)? = nil
) rethrows -> Result {
	try withAppKitAnimation(animation, body, completion: completion)
}

#endif
