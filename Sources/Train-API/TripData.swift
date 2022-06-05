//
//  File.swift
//  
//
//  Created by Frederik Riedel on 05.06.22.
//

import Foundation

public struct TripData {
    public let trainId: String
    public let stops: [JourneyStop]
    
    public var startStop: JourneyStop? {
        return stops.first
    }
    
    public var finalStop: JourneyStop? {
        return stops.last
    }
    
    public var nextStop: JourneyStop? {
        stops.first { stop in
            !stop.passed
        }
    }
    
    
    
    init?(dict: [String: Any]) {
        if let tripDict = dict["trip"] as? [String: Any] {
            if let trainType = tripDict["trainType"] as? String, let connectionId = tripDict["vzn"] as? String {
                self.trainId = "\(trainType) \(connectionId)"
            } else {
                return nil
            }
            
            if let stops = tripDict["stops"] as? [ [String: Any] ] {
                self.stops = stops.compactMap({ stopDict in
                    return JourneyStop(dict: stopDict)
                })
            } else {
                return nil
            }
            
            
            
        } else {
            return nil
        }
    }
}
