# basic-ios-template

 [![SwiftPM 6.2](https://img.shields.io/badge/swiftpm-5.6-ED523F.svg?style=flat)](https://swift.org/download/) [![@maximkrouk](https://img.shields.io/badge/contact-@capture__context-1DA1F2.svg?style=flat&logo=twitter)](https://twitter.com/capture_context)

### Getting started

1. Fork the repo as a template.

2. Create a local folder for your app and navigate to it

```bash
mkdir <YourAppName>
cd <YourAppName>
```

2. Clone the template, rename cloned folder to `App` and navigate to it

```bash
git clone https://github.com/<your-profile>/<your-app-name>-ios.git
mv <your-app-name>-ios App
cd App
```

> You can choose any name or avoid nesting, but we recommend to follow the example (including the case) to get the best result 😌

3. Rename [project.yml](project.yml) and [Previews/.preview.yml](Previews/.preview.yml) contents accordingly to your needs

- bundleIdPrefix: `org-domain.org-host` to your bundleID prefix
- targets: `template-app-universal` to `<your-app-name>-universal`
- info.properties.CFBundleDisplayName: `TemplateApp` to `<YourAppName>`
- see [xcodegen](https://github.com/yonaskolb/XcodeGen) for more configuration info

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
  Resources // Contains shared resources and generated boilerplate, but you can declare target-specific resources too, see https://github.com/capturecontext/spmgen
}
```



> [!NOTE]
>
> _Scripts can be improved later so we advice you to keep an eye on the repo and a tracking reference to our `main` branch to keep your infrastructure up to date_ 🚀



### Recommended dependencies

- https://github.com/capturecontext/swift-declarative-configuration
- https://github.com/capturecontext/swift-package-resources
- https://github.com/capturecontext/package-resources-cli
- https://github.com/capturecontext/swift-capture
- https://github.com/capturecontext/cocoa-aliases
- https://github.com/pointfreeco/swift-parsing
  
- https://github.com/pointfreeco/swift-composable-architecture
  - https://github.com/pointfreeco/swift-identified-collections
  - https://github.com/pointfreeco/swift-concurrency-extras
  - https://github.com/pointfreeco/swift-dependencies
  - https://github.com/pointfreeco/swift-sharing
  - https://github.com/capturecontext/swift-sharing-extensions

> Will be recommended later (yet in alpha or beta)
> - https://github.com/capturecontext/composable-architecture-extensions
> - https://github.com/capturecontext/swift-foundation-extensions
> - https://github.com/capturecontext/swift-cocoa-extensions
