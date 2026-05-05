//
//  EmergencyContact.swift
//  Ambient Assisted Living
//

import Foundation

struct EmergencyContact: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var phone: String
    var relationship: String
    var priority: Int
}
