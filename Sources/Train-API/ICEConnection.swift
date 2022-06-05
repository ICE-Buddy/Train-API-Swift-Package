//
//  ICEConnection.swift
//  ICE Buddy
//
//  Created by Frederik Riedel on 16.11.21.
//

import Foundation
import Alamofire
import CoreLocation
import AppKit
import FredKit

public class ICEConnection {
    
    public static let shared = ICEConnection()
    
    public func loadCurrentTrainData(completion: @escaping (TrainMetaData?) -> Void) {
        AF.request("https://iceportal.de/api1/rs/status").responseJSON { response in
            if let result = response.value as? [String: Any] {
                let metaData = TrainMetaData(dict: result)
                completion(metaData)
            } else {
#if DEBUG
                if let data = try? Data(contentsOf: Bundle.module.url(forResource: "ice", withExtension: "json")!) {
                    let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? [String: Any] {
                        let metaData = TrainMetaData(dict: jsonResult)
                        completion(metaData)
                    }
                }
#else
                // currently not connected to ICE?
                completion(nil)
#endif
            }
        }
    }
    
    public func loadCurrentTripData(completion: @escaping (TripData?) -> Void) {
        AF.request("https://iceportal.de/api1/rs/tripInfo/trip").responseJSON { response in
            if let result = response.value as? [String: Any] {
                let metaData = TripData(dict: result)
                
                
                
                completion(metaData)
            } else {
#if DEBUG

                
                if let data = try? Data(contentsOf: Bundle.module.url(forResource: "paris", withExtension: "json")!) {
                    let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? [String: Any] {
                        let metaData = TripData(dict: jsonResult)
                        
                        completion(metaData)
                    }
                }
#else
                // currently not connected to ICE?
                completion(nil)
#endif
            }
        }
    }
    
}

extension Array where Element == Int {
    private func number(number: Int, matchesWithTzn tzn: String) -> Bool {
        tzn.lowercased() == "tz\(number)" || tzn.lowercased() == "tz \(number)" || tzn.lowercased() == "ice\(number)" || tzn.lowercased() == "ice \(number)" ||
        tzn.lowercased() == "tz0\(number)" || tzn.lowercased() == "tz 0\(number)" || tzn.lowercased() == "ice0\(number)" || tzn.lowercased() == "ice 0\(number)"
    }
    
    func contains(triebzugnummer: String) -> Bool {
        self.contains(where: { number in
            self.number(number: number, matchesWithTzn: triebzugnummer)
        })
    }
}
