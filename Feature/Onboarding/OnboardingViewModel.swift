//
//  OnboardingViewModel.swift
//  voiceMemo
//
//  Created by 최시온 on 11/18/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var onboardingContents: [OnboardingContent]
    
    init(
        onboardingContents: [OnboardingContent] = [
            .init(
                imagefileName: "onboarding_1",
                title: "오늘의 할 일",
                subTitle: "To do list로 언제 어디서든 해야할 일을 한 눈에"
            ),
            .init(
                imagefileName: "onboarding_2",
                title: "똑똑한 나만의 기록장",
                subTitle: "메모장으로 생각나는 기록은 언제드니"
            ),
            .init(
                imagefileName: "onboarding_3",
                title: "하나라도 놓치지 않도록",
                subTitle: "음성 메모 기능으로 놓치고 싶지 않은 기록까지"
            ),
            .init(
                imagefileName: "onboarding_4",
                title: "정확한 시간의 경과",
                subTitle: "타이머 기능으로 원하는 시간을 확인"
            )
        ]
    ) {
        self.onboardingContents = onboardingContents
    }
}



