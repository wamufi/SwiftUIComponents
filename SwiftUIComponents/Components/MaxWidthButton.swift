//
//  MaxWidthButton.swift
//  SwiftUIComponents
//

import SwiftUI

struct MaxWidthButton: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Label("test", systemImage: "button.horizontal.top.press.fill")
            }
            .buttonStyle(MaxWidthButtonStyle(labelColor: .white, backgroundColor: .cyan))
            .padding()
            
            Button {
                
            } label: {
                Label("test", systemImage: "button.horizontal.top.press.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
    }
}

struct MaxWidthButtonStyle: ButtonStyle {
    
    var labelColor = Color.black
    var backgroundColor = Color.accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(labelColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    MaxWidthButton()
}
