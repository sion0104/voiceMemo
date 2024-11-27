//
//  TodoViewModel.swift
//  voiceMemo
//
//  Created by 최시온 on 11/25/24.
//

import Foundation

class TodoViewModel: ObservableObject{
    @Published var title: String
    @Published var time: Date
    @Published var day: Date
    @Published var isDisplayCanlender: Bool
    
    init(
        title: String =  "",
        time: Date = Date(),
        day: Date = Date(),
        isDisplayCanlender: Bool = false
    ) {
        self.title = title
        self.time = time
        self.day = day
        self.isDisplayCanlender = isDisplayCanlender
    }
}

extension TodoViewModel {
    func setIsDisplayCalendar(_ isDisplay: Bool){
        isDisplayCanlender = isDisplay
    }
}
