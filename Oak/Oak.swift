//
// Created by Markus Riegel on 18.08.16.
// Copyright (c) 2016 wag it GmbH. All rights reserved.
//

import Foundation

/**
 Plant Trees to log messages.
 The default Tree, a DebugTree, will use NSLog to print logs to the console.
 */
public class Oak {
    /**
     Plant a new tree.
     This tree will be used to process your logging requests calls.
     
     - Parameter The tree.
     */
    public static func plant(tree: OakTree) {
        forest.append(tree)
    }
    
    /**
     Lumber all trees.
     */
    public static func lumber() {
        
    }
    
    /**
     Create a verbose log.
     
     - Parameter message: The message.
     - (optional) Parameter trace: An optional stack trace generated by NSThread.callStackSymbols()
     */
    public class func v(message: String, _ trace: [String]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        for tree in forest {
            tree.v(message, trace, file, function, line);
        }
    }
    
    /**
     Create a debug log.
     
     - Parameter message: The message.
     - (optional) Parameter trace: An optional stack trace generated by NSThread.callStackSymbols()
     */
    public class func d(_ message: String, _ trace: [String]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        for tree in forest {
            tree.d(message, trace, file, function, line);
        }
    }
    
    /**
     Create an info log.
     
     - Parameter message: The message.
     - (optional) Parameter trace: An optional stack trace generated by NSThread.callStackSymbols()
     */
    public class func i(_ message: String, _ trace: [String]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        for tree in forest {
            tree.i(message, trace, file, function, line);
        }
    }
    
    /**
     Create a warn log.
     
     - Parameter message: The message.
     - (optional) Parameter trace: An optional stack trace generated by NSThread.callStackSymbols()
     */
    public class func w(_ message: String, _ trace: [String]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        for tree in forest {
            tree.w(message, trace, file, function, line);
        }
    }
    
    /**
     Create a error log.
     
     - Parameter message: The message.
     - (optional) Parameter trace: An optional stack trace generated by NSThread.callStackSymbols()
     */
    public class func e(_ message: String, _ trace: [String]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        for tree in forest {
            tree.e(message, trace, file, function, line);
        }
    }
    
    /**
     Create an assert log.
     
     - Parameter message: The message.
     - (optional) Parameter trace: An optional stack trace generated by NSThread.callStackSymbols()
     */
    public class func wtf(_ message: String, _ trace: [String]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        for tree in forest {
            tree.wtf(message, trace, file, function, line);
        }
    }
    
    /**
     The default tree for logging on the main thread.
     */
    public struct DebugTree: OakTree {
        public func log(_ priority: Int, _ file: String, _ function: String, _ line: Int, _ message: String, _ trace: [String]?) {
            var wood = Priority.asString(priority) + "/"
            wood += fileName(file) + "[" + String(line) + "]"
            wood += " " + function +  ": " + message
            if let trace = trace {
                wood += prepareStack(trace)
            }
            NSLog(wood)
        }
        
        public init(){}
    }
    
    /**
     Logging priority.
     */
    public struct Priority {
        public static let VERBOSE = 2;
        public static  let DEBUG = 3;
        public static  let INFO = 4;
        public static  let WARN = 5;
        public static  let ERROR = 6;
        public static  let ASSERT = 7;

        public static func asString(_ priority: Int) -> String {
            switch priority {
            case VERBOSE: return "V"
            case DEBUG: return "D"
            case INFO: return "I"
            case WARN: return "W"
            case ERROR: return "ERROR"
            case ASSERT: return "WTF"
            default: return "X";
            }
        }
    }
    
    static private var forest = [OakTree]();
    
    static private var logQueue: DispatchQueue = {
        return DispatchQueue(label: "io.wagit.oak.logger", attributes: [])
    }()
}

/**
 Implement this protocol for custom logging trees.
 */
public protocol OakTree {
    func log(_ priority: Int, _ file: String, _ function: String, _ line: Int, _ message: String, _ trace: [String]?)
}

/**
 Default implementations for logging methods.
 */
public extension OakTree {
    /**
     Extract the file name from the file path.
     
     - Parameter file: The raw file path supplied by the special literal #file
     
     - Returns: The file name as String.
     */
    public func fileName(_ file: String) -> String {
        let parts = file.components(separatedBy: "/");
        return parts[parts.count - 1].components(separatedBy: ".")[0]
    }
    
    /**
     Convert the stack trace generated by NSThread.callStackSymbols() into a readable output.
     This method also filters probably irrelevant entries.
     
     - Parameter symbols: The output of NSThread.callStackSymbols()
     
     - Returns: A loggable, filtered version of the stack trace.
     */
    public func prepareStack(_ symbols: [String]) -> String {
        var stack = ""
        for symbol in symbols {
            let part = component(_stdlib_demangleName(component(symbol, 3)),0)
            if(part.components(separatedBy: ".").count > 2) {
                stack += "\n\t" + part
            }
        }
        return stack
    }
    
    /**
     Execute a logging request asynchronously.
     Good for production logging, when the performance of the may not be affected by logging.
     Just wrap all of your log() content into a closure and pass it as a parameter to this method.
     
     - Parameter closure: Logging code wrapped in a closure.
     */
    public func async(_ closure: @escaping () -> ()) {
        Oak.logQueue.async(execute: closure)
    }
    
    func component(_ symbol: String, _ pos: Int) -> String {
        return symbol.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
            .components(separatedBy: " ")[pos]
    }
    
    func v(_ message:String, _ trace: [String]?, _ file: String, _ function: String, _ line: Int) {
        log(Oak.Priority.VERBOSE, file, function, line, message, trace)
    }
    
    func d(_ message:String, _ trace: [String]?, _ file: String, _ function: String, _ line: Int) {
        log(Oak.Priority.DEBUG, file, function, line, message, trace)
    }
    
    func i(_ message:String, _ trace: [String]?, _ file: String, _ function: String, _ line: Int) {
        log(Oak.Priority.INFO, file, function, line, message, trace)
    }
    
    func w(_ message:String, _ trace: [String]?, _ file: String, _ function: String, _ line: Int) {
        log(Oak.Priority.WARN, file, function, line, message, trace)
    }
    
    func e(_ message:String, _ trace: [String]?, _ file: String, _ function: String, _ line: Int) {
        log(Oak.Priority.ERROR, file, function, line, message, trace)
    }
    
    func wtf(_ message:String, _ trace: [String]?, _ file: String, _ function: String, _ line: Int) {
        log(Oak.Priority.ASSERT, file, function, line, message, trace)
    }
}
