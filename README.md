# basic-ios-template

SwiftPM-based template for a highly modularized applications

### Getting started

1. Fork the repo as a template.

2. Create a local folder for your app and navigate to it

```bash
mkdir CaptureContext
cd CaptureContext
```

2. Clone the template, rename cloned folder to `App` and navigate to it

```bash
git clone https://github.com/<your_profile>/<your_app>-ios.git
mv <your_app>-ios App # rename cloned folder to 'App'
cd App
```

> You can choose any name or avoid nesting, but we recommend to follow the example to get the best result 😌

3. Rename [project.yml](project.yml), [.config/project.yml](.config/project.yml) and [.config/preview.yml](.config/preview.yml) contents accordingly to your needs

- bundleIdPrefix: `org-domain.org-host` to your bundleID prefix
- targets: `MyTarget` to `<your_app>-ios` 
- info.properties.CFBundleDisplayName: `MyApp` to `<your_app>`

4. Bootstrap the environment

```bash
make bootstrap
```

> See Makefile for details

Than you can commit changes and you are ready for the actual development 😎

```bash
open Package.xcworkspace
```


### Structure

See [Extensions](Extensions/README.md) and [Dependencies](Dependencies/README.md) for more details for these modules

Main work is happenning in the root package.

- `<#Module#>Feature` naming is used for modules user directly interact with
- `<#Service#>` naming modules is used for modules that are used by developers to build feature modules

Basically your `Sources` folder structure will look kinda like this

```swift
Sources { // Main modules
  AppFeature // Entry point for the app, contains AppDelegate, RootViewController, AppState etc., coordinates app flows
  MainFeature // Main app flow, non-main flows may be Onboarding/Admin/Auth for example.
  <#SomeFeature#>Feature // Any other feature
  AppUI // App-specific UI components
  APIClient // Service module example
  Resources // Contains resources and generated boilerplate
}
```

### Recommended dependencies

- https://github.com/pointfreeco/swift-composable-architecture
- https://github.com/pointfreeco/swift-identified-collections
- https://github.com/pointfreeco/swift-parsing
- https://github.com/capturecontext/swift-declarative-configuration
- https://github.com/capturecontext/swift-composable-environment
- https://github.com/capturecontext/swift-standard-clients
- https://github.com/capturecontext/swift-capture
- https://github.com/capturecontext/spmgen
- https://github.com/snapkit/snapkit

> Will be recommended later (yet in alpha or beta)
> - https://github.com/capturecontext/composable-architecture-extensions
> - https://github.com/capturecontext/swift-foundation-extensions
> - https://github.com/capturecontext/swift-cocoa-extensions
> - https://github.com/capturecontext/combine-extensions
> - https://github.com/capturecontext/combine-cocoa
> - https://github.com/capturecontext/combine-cocoa-navigation
> - https://github.com/capturecontext/swift-prelude
> - https://github.com/capturecontext/swift-generic-color
> - https://github.com/capturecontext/swift-palette
