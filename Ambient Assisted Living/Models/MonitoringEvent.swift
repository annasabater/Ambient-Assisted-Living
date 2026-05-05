//
//  MonitoringEvent.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct MonitoringEvent: Codable, Identifiable {
    @DocumentID var id: String?
    var type: EventType
    var severity: Severity
    var deviceId: String
    var room: String?
    var timestamp: Date
    var data: [String: AnyCodable]
    var resolved: Bool

    enum EventType: String, Codable, CaseIterable {
        case fall
        case water
        case presence
        case medication
    }

    enum Severity: String, Codable, CaseIterable {
        case info
        case warning
        case alert
    }
}
