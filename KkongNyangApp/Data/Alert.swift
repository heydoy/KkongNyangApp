//
//  Alert.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/18.
//

import Foundation
import FirebaseDatabase

class Alert {
    var time: String = ""
    var from: String = ""
    var todo: String = ""
    var todoKey: String = ""
    var isFinished: Bool = false
    
    init(withSnapshot: DataSnapshot) {
        self.time = withSnapshot.childSnapshot(forPath: "time").value as? String ?? ""
        self.from = withSnapshot.childSnapshot(forPath: "from").value as? String ?? ""
        self.todo = withSnapshot.childSnapshot(forPath: "todo").value as? String ?? ""
        self.todoKey = withSnapshot.childSnapshot(forPath: "todoKey").value as? String ?? ""
        self.isFinished = withSnapshot.childSnapshot(forPath: "isFinished").value as? Bool ?? false
    }
    
}
