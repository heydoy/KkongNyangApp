//
//  Notice.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/12.
//

import Foundation
import FirebaseDatabase

// 홈화면의 카드에 있는 공지, 이벤트내용 불러오기

class Notice {
    var title       = ""
    var description = ""
    var body        = ""
    var startDate   = ""
    var endDate     = "" //endDate가 없으면 구간표시가 없도록
    var date        = ""
    var image       = ""
    var bgcolor     = ""
    
    init(withSnapshot: DataSnapshot){
        self.title       = withSnapshot.childSnapshot(forPath: "title").value as? String ?? ""
        self.description = withSnapshot.childSnapshot(forPath: "description").value as? String ?? ""
        self.body        = withSnapshot.childSnapshot(forPath: "body").value as? String ?? ""
        self.startDate   = withSnapshot.childSnapshot(forPath: "startDate").value as? String ?? ""
        self.endDate     = withSnapshot.childSnapshot(forPath: "startDate").value as? String ?? ""
        self.date        = endDate != "" ? "\(startDate) ~ \(endDate)" : "\(startDate)"
        self.image       = withSnapshot.childSnapshot(forPath: "image").value as? String ?? ""
        self.bgcolor     = withSnapshot.childSnapshot(forPath: "bgcolor").value as? String ?? ""

    }
}
