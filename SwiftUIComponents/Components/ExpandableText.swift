//
//  ExpandableText.swift
//  SwiftUIComponents
//

import SwiftUI

struct ExpandableText: View {
    @State private var isExpanded = false
    @State private var isTruncated = false
    
    @State private var intrinsicSize = CGSize.zero
    @State private var truncatedSize = CGSize.zero
    @State private var moreTextSize = CGSize.zero
    
    var text: String
    
    var body: some View {
        content
            .lineLimit(isExpanded ? nil : 3)
            .modifier(truncatedMask(size: moreTextSize, isEnabled: !isExpanded && isTruncated))
            .background(
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        truncatedSize = proxy.size
                        isTruncated = truncatedSize != intrinsicSize
                    }
                }
            )
            .background(
                content
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .background(
                        GeometryReader { proxy in
                            Color.clear.onAppear {
                                intrinsicSize = proxy.size
                                isTruncated = truncatedSize != intrinsicSize
                            }
                        }
                    )
            )
            .background(
                Text("more")
                    .hidden()
                    .background(
                        GeometryReader { proxy in Color.clear.onAppear { moreTextSize = proxy.size } }
                    )
            )
            .contentShape(Rectangle())
            .overlay(alignment: .trailingLastTextBaseline) {
                if !isExpanded && isTruncated {
                    Text("more")
                        .font(.caption).bold()
                        .foregroundStyle(.blue)
                }
            }
            .onTapGesture {
                isExpanded.toggle()
            }
    }
    
    private var content: some View {
        Text(text)
            .animation(.easeInOut, value: isExpanded)
    }
}

public struct truncatedMask: ViewModifier {
    let size: CGSize
    let isEnabled: Bool
    
    public func body(content: Content) -> some View {
        content.mask {
            VStack(spacing: 0) {
                Rectangle()
                HStack(spacing: 0) {
                    Rectangle()
                    if isEnabled {
                        LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .black, location: 0), Gradient.Stop(color: .clear, location: 0.9)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: size.width, height: size.height)
                        
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(width: size.width)
                    }
                }
                .frame(height: size.height)
            }
        }
    }
}


#Preview {
    VStack {
        ExpandableText(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean mas. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.\nNulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.\nVivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nsit amet adipiscing sem neque sed ipsum. N")
        
        ExpandableText(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Lorem ipsum dolor sit amet, consectetuer test")
        
        Spacer()
    }
}
