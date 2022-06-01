# Dependencies

A separate target is created for each dependency domain, dependencies can be extended in isolation in such targets.

To add a new dependency:

- Add a dependency to `Package.swift` (Note: Use `_`-prefixed name like `_SnapKit` for `SnapKit`)
- Create a corresponding folder in [Sources](Sources)
- Add `Exports.swift` file in a new target with needed exports
- You can add more files to extend your dependency in isolation
- You can depend on `Extensions` package when extending dependencies, just remember to include the corresponding product from `Extensions` package to your dependency target
- Do not forget to specify products for your dependencies
