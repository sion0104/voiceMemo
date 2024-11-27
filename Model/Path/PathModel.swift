//
//  PathModel.swift
//  voiceMemo
//
//  Created by 최시온 on 11/20/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
