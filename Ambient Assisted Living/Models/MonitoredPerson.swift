//
//  MonitoredPerson.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct MonitoredPerson: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var age: Int
    var photoURL: URL?
    var conditions: [String]
    var emergencyContacts: [EmergencyContact]
    var deviceIds: [String]
}
