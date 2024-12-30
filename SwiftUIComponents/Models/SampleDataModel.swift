//
//  SampleDataModel.swift
//  SwiftUIComponents
//

import Foundation

struct SampleDataModel: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

class SampleData {
    static let firstData = [
        SampleDataModel(text: "1st"),
        SampleDataModel(text: "2nd"),
        SampleDataModel(text: "3rd"),
    ]
    
    static let secondData = [
        SampleDataModel(text: "4th"),
        SampleDataModel(text: "5th"),
        SampleDataModel(text: "6th"),
    ]
    
    static let thirdData = [
        SampleDataModel(text: "7th"),
        SampleDataModel(text: "8th"),
        SampleDataModel(text: "9th"),
    ]
}
