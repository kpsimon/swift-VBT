//
//  StatItem.swift
//  SB-Vball
//
//  Created by Keoni Simon on 2/25/21.
//

import Foundation
import RealmSwift

class StatItem: Object {
    @objc dynamic var dateCreated: Date?
    @objc dynamic var dateString: String = ""
    @objc dynamic var serveIn: Int = 0
    @objc dynamic var serveOut: Int = 0
    @objc dynamic var hits: Int = 0
    @objc dynamic var kills: Int = 0
    @objc dynamic var tips: Int = 0
    @objc dynamic var blocks: Int = 0
    @objc dynamic var digs: Int = 0
}
