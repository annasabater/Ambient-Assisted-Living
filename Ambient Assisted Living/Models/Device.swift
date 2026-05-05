//
//  Device.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct Device: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var macAddress: String
    var firmwareVersion: String
    var pairingToken: String
    var lastSeen: Date
    var online: Bool
    var rooms: [String]
}
