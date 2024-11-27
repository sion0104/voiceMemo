//
//  CustomNavigationBar.swift
//  voiceMemo
//
//  Created by 최시온 on 11/25/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn: Bool
    let isDisaplyRigthBtn: Bool
    let leftBtnAction: () -> Void
    let rigthBtnAction: () -> Void
    let rightBtnType: NavigationBtnType
    
    init(
        isDisplayLeftBtn: Bool = true,
        isDisaplyRigthBtn: Bool = true,
        leftBtnAction: @escaping () -> Void = {},
        rigthBtnAction: @escaping () -> Void = {},
        rightBtnType: NavigationBtnType = .edit 
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisaplyRigthBtn = isDisaplyRigthBtn
        self.leftBtnAction = leftBtnAction
        self.rigthBtnAction = rigthBtnAction
        self.rightBtnType = rightBtnType
    }
    
    var body: some View {
        HStack {
            if isDisplayLeftBtn {
                Button(
                    action: leftBtnAction,
                    label:{Image("leftArrow")}
                )
            }
            
            Spacer()
            
            if isDisaplyRigthBtn{
                Button(
                    action: rigthBtnAction,
                    label: {
                        if rightBtnType == .close {
                            Image("close")
                        } else {
                            Text(rightBtnType.rawValue)
                                .foregroundStyle(.customBlack)
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 20)
    }
}

#Preview {
    CustomNavigationBar()
}
