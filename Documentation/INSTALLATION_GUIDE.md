In this documentation we provide a step-by-step installation guide, with screenshots and further details than the [general documentation](../README.md). Because no one starts app development by knowing how to do everything!

We don't include step-by-step guide for Carthage since most developers using this package manager (usually do already know how to solve issues. In case you encounter an issue with Carthage, please open an Issue here in GitHub and we'll take a look.

## Using Cocoapods

First you need to install Cocoapods using the terminal, create a `Podfile` inside your project and declare the module. Your Podfile should look like this:

```ruby
# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
source 'https://cdn.cocoapods.org/'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

target 'MyProject' do
  pod 'MathExpression'
end
```

Maybe specifying a version. Then you execute `pod install --repo-update` on the project root folder (where the Podfile is located). If everything goes right (no error), from now on you must use the `MyProject.xcworkspace` file to open your project instead of the `MyProject.xcodeproj` (in Finder, it's the one with the white icon instead of the one with the blue icon). This is due to the management from Cocoapods. If you open the `xcodeproj` file you'll have an empty `Pods` folder.

## Swift Package Manager

Since Xcode 11, Swift Package Manager is embedded into Xcode, so we strongly recommend using the Xcode interface to add packages. It's just a few steps:
1. Open your project on Xcode.
2. Open `File` in the top menu, then `Add Packages...`, and you'll see a screen like this:

![Captura de Pantalla 2022-03-30 a las 8 42 19](https://user-images.githubusercontent.com/40358007/160768235-b9acb1b5-256a-4cf2-ad74-a9b68d3ac267.png)

3. On this new screen there is a search bar in the top-right corner. Type-in or paste the URL for this repository (`https://github.com/peredaniel/MathExpression.git`) and it will change to this:

![Captura de Pantalla 2022-03-30 a las 8 45 52](https://user-images.githubusercontent.com/40358007/160768505-92340b16-9754-4848-8537-16006db93752.png)

4. Change "Dependency Rule" to "Up to Next Major Version":

![Captura de Pantalla 2022-03-30 a las 8 47 06](https://user-images.githubusercontent.com/40358007/160768691-7ec669e0-0ea4-4377-b30f-1074b5c0ebc8.png)

5. Finally tap "Add Package" on the bottom-right corner of the screen.
6. This will fetch the `Package.swift` file in this repository, and a confirmation screen appears:

![Captura de Pantalla 2022-03-30 a las 8 48 11](https://user-images.githubusercontent.com/40358007/160768895-ceac054b-f290-4ea7-b794-bd3a1e299a4e.png)

7. Unless you are managing more than a single target (usually you don't), simply click "Add Package". Xcode will now fetch the files in the repository and add them to your project:

![Captura de Pantalla 2022-03-30 a las 8 49 44](https://user-images.githubusercontent.com/40358007/160769124-045001ae-27de-4343-a564-c3130d3d4eac.png)

From then, you can use `import MathExpression` in any Swift file belonging to the same target.

### Manual installation

Clone this repository into your hard-drive, or download it as a ZIP file and uncompress it. Then drag and drop the `Sources` folder into any group inside your Project **in Xcode**. The following screen should appears:

![Captura de Pantalla 2022-03-30 a las 8 53 21](https://user-images.githubusercontent.com/40358007/160769769-581abf5a-9a80-4f66-bab7-c5278260cfeb.png)

Make sure to check "Copy items if needed". We also recommend using "Create groups" instead of "Create folder references", but this is a personal choice. Your project structure should now look like this:

![Captura de Pantalla 2022-03-30 a las 8 54 59](https://user-images.githubusercontent.com/40358007/160770022-08d22638-a1a0-41db-8090-6285f8a651ce.png)

Now you can use any class, struct or extension as if they were defined in your project (since, in fact, they are!), so no need to add `import MathExpression` when you want to use it. In fact, the module does not exist: the files are treated as your own in your project, in the same way as any other file you add to it.
