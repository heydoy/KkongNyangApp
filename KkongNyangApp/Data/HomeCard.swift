//
//  HomeCard.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import Foundation

struct HomeCard {
    var image: String
    var imageBackground: String //컬러
    var title: String
    var description: String
    var date: String
}


extension HomeCard {
    static let list: [HomeCard] = [
        HomeCard(image: "homecard1",
                 imageBackground: "homebg-1",
                 title: "친구초대 이벤트",
                 description: """
                    꽁냥에 친구를 초대하시면
                    프리미엄 혜택이 60일 더!
                    """,
                 date: "2022.08.12 ~ 2022.09.01"),
        HomeCard(image: "homecard2",
                 imageBackground: "homebg-2",
                 title: "고양이 영양제추천",
                 description: """
                    고양이 연령별로 필요한 영양이
                    모두 다르다는 것을 아시나요?
                    """,
                 date: "2022.07.18")
    ]
}
