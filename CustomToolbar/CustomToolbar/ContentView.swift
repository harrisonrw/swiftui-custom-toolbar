//
//  ContentView.swift
//  CustomToolbar
//
//  Created by Robert Harrison on 2/3/25.
//

import SwiftUI

struct SampleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(.black)
            .font(.system(size: 24))
    }
}

enum NavToolbarItem {
    case profile
    case home
    case cloud
    case folder
}

struct ToolbarButton: View {
    let identifier: NavToolbarItem
    let image: String
    @Binding var selectedToolbarItem: NavToolbarItem
    var namespace: Namespace.ID
    
    var body: some View {
        Button {
            selectedToolbarItem = identifier
        } label: {
            ZStack {
                if selectedToolbarItem == identifier {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "hoverEffect", in: namespace)
                }
                
                Image(systemName: image)
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedToolbarItem: NavToolbarItem = .home
    @Namespace private var animationNamespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                switch selectedToolbarItem {
                case .profile:
                    SampleView(title: "Profile")
                case .home:
                    SampleView(title: "Home")
                case .cloud:
                    SampleView(title: "Cloud")
                case .folder:
                    SampleView(title: "Folder")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 15) {
                        ToolbarButton(identifier: .profile,
                                      image: "person.circle.fill",
                                      selectedToolbarItem: $selectedToolbarItem,
                                      namespace: animationNamespace)
                        
                        ToolbarButton(identifier: .home,
                                      image: "house.fill",
                                      selectedToolbarItem: $selectedToolbarItem,
                                      namespace: animationNamespace)
                        
                        ToolbarButton(identifier: .cloud,
                                      image: "cloud.fill",
                                      selectedToolbarItem: $selectedToolbarItem,
                                      namespace: animationNamespace)
                        
                        ToolbarButton(identifier: .folder,
                                      image: "folder.fill",
                                      selectedToolbarItem: $selectedToolbarItem,
                                      namespace: animationNamespace)
                    }
                    .background(Color.black.opacity(0.7))
                    .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
