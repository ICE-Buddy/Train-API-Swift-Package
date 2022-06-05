//
//  File.swift
//  
//
//  Created by Frederik Riedel on 05.06.22.
//

import Foundation
import CoreLocation

public struct JourneyStop {
    public let evaNr: String
    public let name: String
    
    public let actualDepartureTime: Date?
    public let actualArrivalTime: Date?
    
    public let scheduledDepartureTime: Date?
    let scheduledArrivalTime: Date?
    
    public let departureDelay: String
    public let scheduledTrack: String
    public let actualTrack: String
    
    public let passed: Bool
    
    public let coordinate: CLLocationCoordinate2D
    
    public var humanReadableArrivalTime: String {
        if let actualArrivalTime = actualArrivalTime {
            return actualArrivalTime.minuteTimeString
        }
        
        if let scheduledArrivalTime = scheduledArrivalTime {
            return scheduledArrivalTime.minuteTimeString
        }
        
        if let actualDepartureTime = actualDepartureTime {
            return actualDepartureTime.minuteTimeString
        }
        
        if let scheduledDepartureTime = scheduledDepartureTime {
            return scheduledDepartureTime.minuteTimeString
        }
        
        
        return "Time Unknown"
    }
    
    public init?(dict: [String: Any]) {
        if let station = dict["station"] as? [String: Any] {
            
            if let evaNr = station["evaNr"] as? String {
                self.evaNr = evaNr
            } else {
                return nil
            }
            
            if let stopName = station["name"] as? String {
                self.name = stopName
            } else {
                return nil
            }
            
            if let geocoordinates = station["geocoordinates"] as? [String: Double] {
                if let latitude = geocoordinates["latitude"], let longitude = geocoordinates["longitude"] {
                    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                } else {
                    return nil
                }
            } else {
                return nil
            }
            
        } else {
            return nil
        }
        
        if let info = dict["info"] as? [String: Any] {
            if let passed = info["passed"] as? Bool {
                self.passed = passed
            } else {
                return nil
            }
        } else {
            return nil
        }
        
        if let track = dict["track"] as? [String: Any] {
            
            if let actualTrack = track["actual"] as? String {
                if actualTrack.isEmpty {
                    self.actualTrack = "–"
                } else {
                    self.actualTrack = actualTrack
                }
                
            } else {
                return nil
            }
            
            if let scheduledTrack = track["scheduled"] as? String {
                self.scheduledTrack = scheduledTrack
            } else {
                self.scheduledTrack = "–"
            }
            
        } else {
            return nil
        }
        
        if let timetable = dict["timetable"] as? [String: Any] {
            if let actualDepartureTime = timetable["actualDepartureTime"] as? Double {
                self.actualDepartureTime = Date(timeIntervalSince1970: actualDepartureTime / 1000.0)
            } else {
                self.actualDepartureTime = nil
            }
            
            if let actualArrivalTime = timetable["actualArrivalTime"] as? Double {
                self.actualArrivalTime = Date(timeIntervalSince1970: actualArrivalTime / 1000.0)
            } else {
                self.actualArrivalTime = nil
            }
            
            if let scheduledArrivalTime = timetable["scheduledArrivalTime"] as? Double {
                self.scheduledArrivalTime = Date(timeIntervalSince1970: scheduledArrivalTime / 1000.0)
            } else {
                self.scheduledArrivalTime = nil
            }
            
            if let scheduledDepartureTime = timetable["scheduledDepartureTime"] as? Double {
                self.scheduledDepartureTime = Date(timeIntervalSince1970: scheduledDepartureTime / 1000.0)
            } else {
                self.scheduledDepartureTime = nil
            }
            
            if let departureDelay = timetable["departureDelay"] as? String {
                self.departureDelay = departureDelay
            } else {
                return nil
            }
            
        } else {
            return nil
        }
    }
}
