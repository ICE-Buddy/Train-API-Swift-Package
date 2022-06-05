//
//  File.swift
//  
//
//  Created by Frederik Riedel on 05.06.22.
//

import Foundation

public enum InternetConnection {
    case high, unstable
    
    static func from(rawString: String) -> InternetConnection {
        if rawString == "HIGH" {
            return .high
        }
        return .unstable
    }
    
    public var localizedString: String {
        switch self {
        case .high:
            return "High"
        case .unstable:
            return "Unstable"
        }
    }
}
