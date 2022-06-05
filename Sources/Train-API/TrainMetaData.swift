//
//  File.swift
//  
//
//  Created by Frederik Riedel on 05.06.22.
//

import Foundation
import CoreLocation

public struct TrainMetaData {
    public let speed: Double
    public let internetConnection: InternetConnection
    public let trainType: TrainType
    public let trainId: String
    public let currentLocation: CLLocationCoordinate2D
    public let timestamp: Date
    
    public init?(dict: [String: Any]) {
        
        if let speed = dict["speed"] as? Double {
            self.speed = speed
        } else {
            return nil
        }
        
        if let internetConnectivity = dict["connectivity"] as? [String: Any] {
            if let currentState = internetConnectivity["currentState"] as? String {
                self.internetConnection = InternetConnection.from(rawString: currentState)
            } else {
                return nil
            }
        } else {
            return nil
        }
        
        if let triebZugNummer = dict["tzn"] as? String {
            self.trainType = TrainType.trainType(from: triebZugNummer)
            self.trainId = triebZugNummer
        } else {
            return nil
        }
        
        if let longitude = dict["longitude"] as? Double, let latitude = dict["latitude"] as? Double {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.currentLocation = coordinate
        } else {
            return nil
        }
        
        if let serverTime = dict["serverTime"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: serverTime / 1000)
        } else {
            return nil
        }
    }
}
