//
//  TodoListView.swift
//  voiceMemo
//
//  Created by 최시온 on 11/25/24.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        ZStack{
            // 투두 셀 리스트
            VStack{
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rigthBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                TitleView()
                
                AnnouncementView()
            }
        }
    }
}

// MARK: - TodoList 타이틀 뷰
private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        HStack{
            if todoListViewModel.todos.isEmpty{
                Text("To do list를\n추가해 보세요.")
            } else {
                Text("To do list \(todoListViewModel.todos.count)개가\n있습니다.")
            }
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - TodoList 안내 뷰
private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15, content: {
            Spacer()
            
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 20, height: 20)
            Text("\"매일 아침 5시 운동하자!\"")
            Text("\"내일 8시 수강 신청\"")
            Text("\"1시 반 점심약속 리마인드\"")
            
            Spacer()
        })
        .font(.system(size: 16))
        .foregroundStyle(.customGray2)
    }
}

#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
