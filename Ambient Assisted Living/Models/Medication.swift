//
//  Medication.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct Medication: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var dosage: String
    var schedule: [MedicationTime]
    var active: Bool
}

struct MedicationTime: Codable, Identifiable, Hashable {
    var hour: Int
    var minute: Int
    var daysOfWeek: [Int]

    var id: String {
        "\(hour):\(minute):\(daysOfWeek.map(String.init).joined(separator: ","))"
    }
}
