//
//  Alert.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/18.
//

import Foundation
import FirebaseDatabase

class Alert: Comparable {
    static func < (lhs: Alert, rhs: Alert) -> Bool {
        return lhs.time < rhs.time
    }
    
    static func == (lhs: Alert, rhs: Alert) -> Bool {
        return lhs.todo == rhs.todo
    }
    

    var key: String = ""
    var time: String = ""
    var askedFrom: String = ""
    var finishedFrom: String = ""
    var todo: String = ""
    var todoKey: String = ""
    var isFinished: Bool = false
    var isAsked: Bool = false
    
    init(withSnapshot: DataSnapshot) {
        self.key = withSnapshot.key
        self.time = withSnapshot.childSnapshot(forPath: "time").value as? String ?? ""
        self.askedFrom = withSnapshot.childSnapshot(forPath: "askedFrom").value as? String ?? ""
        self.finishedFrom = withSnapshot.childSnapshot(forPath: "finishedFrom").value as? String ?? ""
        self.todo = withSnapshot.childSnapshot(forPath: "todo").value as? String ?? ""
        self.todoKey = withSnapshot.childSnapshot(forPath: "todoKey").value as? String ?? ""
        self.isFinished = withSnapshot.childSnapshot(forPath: "isFinished").value as? Bool ?? false
        self.isAsked = withSnapshot.childSnapshot(forPath: "isAsked").value as? Bool ?? false
    }
    
}
