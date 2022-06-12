//
//  FinishedTodo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import Foundation

struct FinishedTodo {
    let image: String
    let backgroundColor: String
    let title: String
}


extension FinishedTodo {
    static let list: [FinishedTodo] = [
        FinishedTodo(image: "finished-bathtub", backgroundColor: "finishedList-1", title: "산이 목욕"),
        FinishedTodo(image: "finished-food", backgroundColor: "finishedList-2", title: "아침밥주기"),
        FinishedTodo(image: "finished-food", backgroundColor: "finishedList-3", title: "저녁밥주기"),
        FinishedTodo(image: "finished-bathtub", backgroundColor: "finishedList-4", title: "첫째 씻기기"),
        FinishedTodo(image: "finished-bathtub", backgroundColor: "finishedList-4", title: "둘째 씻기기"),
        FinishedTodo(image: "finished-food", backgroundColor: "finishedList-2", title: "밥그릇 설거지"),
    ]
}
