//
//  ControlDevice.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct ControlDevice: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var type: ControlType
    var deviceId: String
    var room: String
    var state: ControlState
    var schedules: [ControlSchedule]

    enum ControlType: String, Codable, CaseIterable {
        case light
        case valve
    }
}

struct ControlState: Codable, Hashable {
    var on: Bool
    var brightness: Int?
}

struct ControlSchedule: Codable, Identifiable, Hashable {
    var hour: Int
    var minute: Int
    var daysOfWeek: [Int]
    var desiredOn: Bool
    var desiredBrightness: Int?

    var id: String {
        let days = daysOfWeek.map(String.init).joined(separator: ",")
        let bright = desiredBrightness.map(String.init) ?? "-"
        return "\(hour):\(minute):\(days):\(desiredOn):\(bright)"
    }
}
