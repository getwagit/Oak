![Oak](logo.png)

# Oak 
A simple logging library for Swift, inspired by [Timber](https://github.com/JakeWharton/timber).

## Installation

#### Carthage
Add the following to your `Cartfile`:
```
github "getwagit/Oak" ~> 2.2.0 
```

#### CocoaPods

Integrate Oak into your `Podfile`
```
pod 'Oak', '~> 2.2.0'
```

## Usage
For simple debug usage plant the `DebugTree` in your AppDelegate.
```Swift
Oak.plant(Oak.DebugTree())
```
Import Oak in each source file.
```Swift
import Oak
```
And start logging like it's 1999.
```Swift
Oak.v("Verbose Log")
Oak.d("Debug Log")
Oak.i("Info Log")
Oak.w("Warn Log")
Oak.e("Error Log")
Oak.wtf("Wtf Log")
```

## Advanced
You can create your own trees to specify how logging should be done.
```Swift
struct ProdTree: OakTree {
    func log(priority: Int, _ file: String, _ function: String, _ line: Int, _ message: String) {
        if(priority < Oak.Priority.ERROR) { // Use the priority to filter logs.
            return
        }
        async({ // Dispatch logs asynchronously using Oak's queue.
            let fileName = self.fileName(file) // Helper method to extract the file name.
            let priorityName = Oak.Priority.asString(priority) // Convert priority to a String.
            
            // ...
            // Do whatever you like with the data, e.g. send infos to a logging endpoint or prompt beta users to report the bug.
        })
    }
}
```
Plant trees depending on your environment: Add `-DDEBUG` to the debug entry at Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags.
```Swift
#if DEBUG
  Oak.plant(Oak.DebugTree())
#else
  Oak.plant(ProTree())
#endif
```

## Contributing
Contributions are welcome! Please use the branch `develop` as base/target. If you modifiy the `project.pbxproj` file, use [xUnique](https://github.com/truebit/xUnique).

## License 
Oak is available under the MIT license.
