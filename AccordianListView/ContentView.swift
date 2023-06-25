//
//  ContentView.swift
//  AccordianListView
//
//  Created by Manoj Kumar on 22/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isExpanded: Bool = false
    

    var body: some View {
        List {
                    Section(header: Text("Section 1")) {
                        NestedAccordionView(level: 1)
                    }
                }
    }
}

struct NestedAccordionView: View {
    @State private var isExpanded: Bool = false
    let level: Int
    let maxLevel: Int = 3 // Maximum number of nested levels
    
    var body: some View {
        if level > maxLevel {
            return AnyView(EmptyView()) // Return an empty view at the maximum nested level
        } else {
            return AnyView(
                DisclosureGroup(isExpanded: $isExpanded) {
                    ForEach(1...3, id: \.self) { index in
                        NestedAccordionView(level: level + 1) // Recursively create nested accordion views
                    }
                } label: {
                    Button {
                        isExpanded = !isExpanded

                    } label: {
                        Label(title: {
                                    Text("Level \(level) Items")
                                .foregroundColor(.red)
                                }, icon: {
                                    Image(systemName:!isExpanded ? "chevron.forward" : "chevron.down")
                                        .renderingMode(.template)
                                        .foregroundStyle(.blue)
                                } )
                         
                    }
                }
                    .accentColor(.clear)
                .animation(Animation.linear, value: UUID())
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
