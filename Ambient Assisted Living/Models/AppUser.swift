//
//  AppUser.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore

struct AppUser: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var email: String
    var displayName: String
    var phone: String?
    var createdAt: Date
}
