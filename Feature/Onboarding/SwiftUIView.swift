////
////  OnboardingView.swift
////  voiceMemo
////
////  Created by 최시온 on 11/18/24.
////
//
//import SwiftUI
//
//struct OnboardingView: View {
//    @StateObject private var onboardingViewModel = OnboardingViewModel()
//    
//    var body: some View {
//        // TODO: - 화면 전환 구현 필요
//        OnboardingContentView(onboardingViewModel: onboardingViewModel)
//    }
//}
//
//// MARK: - 온보딩 컨텐츠 뷰
//private struct OnboardingContentView: View {
//    @ObservedObject private var onboardingViewModel: OnboardingViewModel
//    
//    fileprivate init(onboardingViewModel: OnboardingViewModel) {
//        self.onboardingViewModel = onboardingViewModel
//    }
//    
//    fileprivate var body: some View {
//        VStack{
//            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
//            StartBtnView()
//            Spacer()
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//}
//
//// MARK: - 온보딩 셀 리스트 뷰
//private struct OnboardingCellListView: View {
//  @ObservedObject private var onboardingViewModel: OnboardingViewModel
//  @State private var selectedIndex: Int
//  
//  fileprivate init(
//    onboardingViewModel: OnboardingViewModel,
//    selectedIndex: Int = 0
//  ) {
//    self.onboardingViewModel = onboardingViewModel
//    self.selectedIndex = 0
//  }
//  
//  fileprivate var body: some View {
//    GeometryReader { geometry in
//      TabView(selection: $selectedIndex) {
//          ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, onboardingContent in
//          OnboardingCellView(onboardingContent: onboardingContent)
//            .tag(index)
//        }
//      }
//      .tabViewStyle(.page(indexDisplayMode: .never))
//      .frame(width: geometry.size.width, height: geometry.size.height)
//      .background(
//        selectedIndex % 2 == 0
//        ? Color.customSky
//        : Color.customBackgroundGreen
//      )
//      .clipped()
//    }
//  }
//}
//
//// MARK: - 온보딩 셀 뷰
//private struct OnboardingCellView: View {
//    private var onboardingContent: OnboardingContent
//    
//    fileprivate init(onboardingContent: OnboardingContent) {
//        self.onboardingContent = onboardingContent
//    }
//    
//    fileprivate var body: some View {
//        VStack{
//            Spacer()
//                .frame(height: 100)
//            
//            Image(onboardingContent.imagefileName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 600)
//            
//            HStack{
//                Spacer()
//                    .frame(width: 20)
//                
//                VStack{
//                    Spacer()
//                        .frame(height : 50)
//                    Text(onboardingContent.title)
//                        .font(.system(size: 20, weight: .bold))
//                    
//                    Spacer()
//                        .frame(height: 20)
//                        .background(.green)
//                    
//                    Text(onboardingContent.subTitle)
//                        .font(.system(size: 20))
//                        .frame(maxWidth: .infinity, alignment: .center)
//                    
//                    Spacer()
//                        .frame(height: 100)
//                }
//                
//                
//                Spacer()
//                    .frame(width: 20)
//            }
//            .background(.customWhite)
//            .cornerRadius(0)
//            .shadow(radius: 10)
//
//        }
//
//    }
//}
//
//// MARK: - 시작하기 버튼 뷰
//private struct StartBtnView: View {
//    fileprivate var body: some View {
//        Button(
//            action: {},
//            label: {
//                HStack{
//                    Text("시작하기")
//                        .font(.system(size: 20, weight: .medium))
//                        .foregroundColor(.customGreen)
//                    
//                    Image("startHome")
//                        .renderingMode(.template)
//                        .foregroundColor(.customGreen)
//                }
//            }
//        )
//    }
//}
//
//#Preview {
//    OnboardingView()
//}
//
