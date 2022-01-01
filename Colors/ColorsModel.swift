//
//  ColorsModel.swift
//  Colors
//
//  Created by Daniel Ayala on 28/12/21.
//

import SwiftUI

enum ColorsModel: String, CaseIterable, Identifiable {
    case bubblegum
    case buttercup
    case lavender
    case magenta
    case periwinkle
    case poppy
    case seafoam
    case sky
    case tan
    case teal
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .magenta: return .black
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
    
    var url: URL {
        URL(string: "game:///\(rawValue)")!
    }
}
