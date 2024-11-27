//
//  OnboardingContent.swift
//  voiceMemo
//
//  Created by 최시온 on 11/18/24.
//

import Foundation

struct OnboardingContent: Hashable {
    var imagefileName: String
    var title: String
    var subTitle: String
    
    init(
        imagefileName: String,
        title: String,
        subTitle: String
    ) {
        self.imagefileName = imagefileName
        self.title = title
        self.subTitle = subTitle
    }
}

