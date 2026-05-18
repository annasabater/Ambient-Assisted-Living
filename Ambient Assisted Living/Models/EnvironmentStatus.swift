//
//  EnvironmentStatus.swift
//  Ambient Assisted Living
//

import Foundation
import SwiftUI

enum EnvironmentStatus {
    case comfortable
    case attention
    case alert

    var label: String {
        switch self {
        case .comfortable: "Confortable"
        case .attention: "Atención"
        case .alert: "Alerta"
        }
    }

    var color: Color {
        switch self {
        case .comfortable: AppTheme.success
        case .attention: AppTheme.warning
        case .alert: AppTheme.danger
        }
    }

    private var severity: Int {
        switch self {
        case .comfortable: 0
        case .attention: 1
        case .alert: 2
        }
    }
}

enum EnvironmentRange {
    static func evaluateTemperature(_ celsius: Double) -> EnvironmentStatus {
        switch celsius {
        case 18.0...24.0: .comfortable
        case 15.0..<18.0: .attention
        case let value where value > 24.0 && value <= 28.0: .attention
        default: .alert
        }
    }

    static func evaluateHumidity(_ percent: Double) -> EnvironmentStatus {
        switch percent {
        case 40.0...60.0: .comfortable
        case 30.0..<40.0: .attention
        case let value where value > 60.0 && value <= 70.0: .attention
        default: .alert
        }
    }

    static func combined(_ t: EnvironmentStatus, _ h: EnvironmentStatus) -> EnvironmentStatus {
        let order: [EnvironmentStatus] = [.comfortable, .attention, .alert]
        let tIndex = order.firstIndex(of: t) ?? 0
        let hIndex = order.firstIndex(of: h) ?? 0
        return order[max(tIndex, hIndex)]
    }
}

struct EnvironmentReading: Identifiable, Codable {
    var id: UUID
    var timestamp: Date
    var temperature: Double
    var humidity: Double
    var deviceId: String
    var room: String?

    init(
        id: UUID = UUID(),
        timestamp: Date,
        temperature: Double,
        humidity: Double,
        deviceId: String,
        room: String? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.temperature = temperature
        self.humidity = humidity
        self.deviceId = deviceId
        self.room = room
    }
}
