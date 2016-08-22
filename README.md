# Oak
A most simple logging library for iOS that tries to bring the greatness of [Timber](https://github.com/JakeWharton/timber) to Swift.

## Installation with Carthage
Add the following to your `Cartfile`:
```
github "getwagit/Oak" ~> 1.0 
```

## Debug Usage
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
// You can also pass stack traces to each logging method:
Oak.e("Oh no! An error!", NSThread.callStackSymbols())
```

## Advanced Usage
You can create your own trees to specify how logging should be done.
```Swift
struct ProdTree: OakTree {
    func log(priority: Int, _ file: String, _ function: String, _ line: Int, _ message: String, _ trace: [String]?) {
        if(priority < Oak.Priority.ERROR) { // Use the priority to filter logs.
            return
        }
        async({ // Dispatch logs asynchronously using Oak's queue.
            let fileName = self.fileName(file) // Helper method to extract the file name.
            let stack = self.prepareStack(stack) // Helper method to reformat the stack trace.
            let priorityName = Oak.Priority.asString(priority) // Convert priority to a String.
            
            // ...
            // Do whatever you like with the data, e.g. send infos to a logging endpoint or prompt beta users to report the bug.
        })
    }
}
```
Plant trees depending on your environment.
```Swift
#if DEBUG
  Oak.plant(Oak.DebugTree())
#else
  Oak.plant(ProTree())
#endif
```
