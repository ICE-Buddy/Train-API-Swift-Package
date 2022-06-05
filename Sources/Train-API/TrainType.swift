//
//  File.swift
//  
//
//  Created by Frederik Riedel on 05.06.22.
//

import Foundation
import AppKit

public enum TrainType: CaseIterable {
    
    case BR401, BR402, BR403, BR406, BR407, BR408, BR411, BR415, BR412, unknown
    
    private var triebZugNummern: [Int] {
        switch self {
        case .BR401:
            return [Int](101...199)
        case .BR402:
            return [Int](201...299)
        case .BR403:
            return [Int](301...399)
        case .BR406:
            return [Int](4601...4699)
        case .BR407:
            return [Int](701...799) + [Int](4701...4799)
        case .BR408:
            return [Int](801...899)
        case .BR411:
            return [Int](1101...1199)
        case .BR415:
            return [Int](1501...1599)
        case .BR412:
            return [Int](9001...9999)
        case .unknown:
            return []
        }
    }
    
    public var humanReadableTrainType: String {
        switch self {
        case .BR401:
            return "ICE 1"
        case .BR402:
            return "ICE 2"
        case .BR403, .BR406, .BR407:
            return "ICE 3"
        case .BR408:
            return "ICE 3 Neo"
        case .BR411, .BR415:
            return "ICE T"
        case .BR412:
            return "ICE 4"
        case .unknown:
            return "Unknown Train Type"
        }
    }
    
    
    public static func trainType(from triebZugNummer: String) -> TrainType {
        return TrainType.allCases.first { trainType in
            trainType.triebZugNummern.contains(triebzugnummer: triebZugNummer)
        } ?? .unknown
    }
    
#if SWIFT_PACKAGE
    public var trainIcon: NSImage {
        
        
        switch self {
        case .BR401:
            return Bundle.module.image(forResource: "BR401")!
        case .BR402:
            return Bundle.module.image(forResource: "BR402")!
        case .BR403:
            return Bundle.module.image(forResource: "BR403")!
        case .BR406:
            return Bundle.module.image(forResource: "BR406")!
        case .BR407:
            return Bundle.module.image(forResource: "BR407")!
        case .BR408:
            return Bundle.module.image(forResource: "BR408")!
        case .BR411:
            return Bundle.module.image(forResource: "BR411")!
        case .BR415:
            return Bundle.module.image(forResource: "BR415")!
        case .BR412:
            return Bundle.module.image(forResource: "BR412")!
        case .unknown:
            return Bundle.module.image(forResource: "BR401")!
        }
    }
#endif
}
