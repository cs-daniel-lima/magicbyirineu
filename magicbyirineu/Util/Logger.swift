//
//  Logger.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class Logger {
    
    // MARK: - NSObject
    static func log(in classBeingLogged:NSObject, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        
        print("💬 \(customMessage)")
    }
    
    static func logError(in classBeingLogged:NSObject, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        _ = NSError(domain: "com.kaiquemagno.concreteTest", code: 1, userInfo: ["description" : customMessage])
        print("❌ \(customMessage)")
    }
    
    static func logWarning(in classBeingLogged:NSObject, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        print("⚠️ \(customMessage)")
    }
    
    // MARK: - NSObject.Type
    static func log(in classBeingLogged:NSObject.Type, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        print("💬 \(customMessage)")
    }
    
    static func logError(in classBeingLogged:NSObject.Type, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        _ = NSError(domain: "com.kaiquemagno.concreteTest", code: 1, userInfo: ["description" : message])
        print("❌ \(customMessage)")
    }
    
    static func logWarning(in classBeingLogged:NSObject.Type, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        print("⚠️ \(customMessage)")
    }
    
    // MARK: - Any
    static func log(in classBeingLogged:Any, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        
        print("💬 \(customMessage)")
    }
    
    static func logError(in classBeingLogged:Any, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        _ = NSError(domain: "com.kaiquemagno.concreteTest", code: 1, userInfo: ["description" : customMessage])
        print("❌ \(customMessage)")
    }
    
    static func logWarning(in classBeingLogged:Any, function:String=#function, message:String){
        let customMessage = "\(String(describing:classBeingLogged)) - \(function) - \(message)"
        print("⚠️ \(customMessage)")
    }
}
