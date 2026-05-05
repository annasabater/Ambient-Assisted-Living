//
//  MedicationIntake.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct MedicationIntake: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var medicationId: String
    var scheduledAt: Date
    var takenAt: Date?
    var status: IntakeStatus

    enum IntakeStatus: String, Codable, CaseIterable {
        case scheduled
        case taken
        case missed
        case skipped
    }
}
