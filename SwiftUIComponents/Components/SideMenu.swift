//
//  SideMenu.swift
//  SwiftUIComponents
//

import SwiftUI

struct SideMenu: View {
    @State private var firstSelectedDataItem: SampleDataModel?
    @State private var secondSelectedDataItem: SampleDataModel?
    @State private var thirdSelectedDataItem: SampleDataModel?
    
    @State private var isOpened: Bool = false
    
    var body: some View {
        SideMenuView(isOpened: $isOpened) {
            List(SampleData.firstData, selection: $firstSelectedDataItem) { item in
                NavigationLink(item.text, value: item)
            }
        } detail: {
            NavigationStack {
                VStack(alignment: .leading) {
                    if firstSelectedDataItem != nil {
                        Text("Previously Selected Item: \(firstSelectedDataItem!.text)")
                    }
                    
                    List(SampleData.secondData, selection: $secondSelectedDataItem) { item in
                        NavigationLink(item.text, value: item)
                    }
                    .navigationTitle("Content")
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isOpened.toggle()
                        } label: {
                            Image(systemName: "sidebar.left")
                        }
                    }
                }
            }
        }
    }
}

public struct SideMenuView<Sidebar, Detail> : View where Sidebar : View, Detail : View {
    
    @Binding private var isOpened: Bool
    
    @ViewBuilder public var sidebar: Sidebar
    @ViewBuilder public var detail: Detail
    
    public init(
        isOpened: Binding<Bool>,
        @ViewBuilder sidebar: () -> Sidebar,
        @ViewBuilder detail: () -> Detail
    ) {
        self._isOpened = isOpened
        
        self.sidebar = sidebar()
        self.detail = detail()
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            detail
                .overlay(Color(.black).opacity(isOpened ? 0.3 : 0))
                .onTapGesture {
                    withAnimation(.easeInOut) { isOpened = false }
                }
            
            if isOpened {
                sidebar
                    .frame(width: 300)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: isOpened)
        .environment(\.isSideMenuOpened, $isOpened)
    }
}

private struct SideMenuViewOpenedKey: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    public var isSideMenuOpened: Binding<Bool> {
        get { self[SideMenuViewOpenedKey.self] }
        set { self[SideMenuViewOpenedKey.self] = newValue }
    }
}

/*
public struct SideMenuPresentationMode {
    @Binding private var _isOpened: Bool

    init(isOpened: Binding<Bool>) {
        __isOpened = isOpened
    }

    public var isOpened: Bool { _isOpened }

    public mutating func open() {
        if !_isOpened {
            _isOpened = true
        }
    }

    public mutating func close() {
        if !_isOpened {
            _isOpened = true
        }
    }
}

extension Binding where Value == Bool {
    func mappedToSideMenuPresentationMode() -> Binding<SideMenuPresentationMode> {
        Binding<SideMenuPresentationMode>(get: {
            SideMenuPresentationMode(isOpened: self)
        }, set: { newValue in
            self.wrappedValue = newValue.isOpened
        })
    }
}

extension SideMenuPresentationMode {
    static var placeholder: SideMenuPresentationMode {
        SideMenuPresentationMode(isOpened: .constant(false))
    }
}
private struct SideMenuPresentationModeKey: EnvironmentKey {
    static var defaultValue: Binding<SideMenuPresentationMode> = .constant(.placeholder)
}

extension EnvironmentValues {
    public var sideMenuPresentationMode: Binding<SideMenuPresentationMode> {
        get { self[SideMenuPresentationModeKey.self] }
        set { self[SideMenuPresentationModeKey.self] = newValue }
    }
}
 */

//#Preview {
//    SideMenu()
//}
