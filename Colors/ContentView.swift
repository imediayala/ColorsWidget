//
//  ContentView.swift
//  Colors
//
//  Created by Daniel Ayala on 27/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var activeID: String?
    
    var colorsList: [ColorsModel] {
        return ColorsModel.allCases
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(colorsList, id: \.self) { color in
                        NavigationLink(destination: DestinationView(color: color), tag: color.id, selection: $activeID){
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(color.mainColor)
                                .frame(height: 80)
                                .padding()
                            
                                .overlay(Text("\(color.name)")
                                            .bold()
                                            .font(.title)
                                            .foregroundColor(.black)
                                )
                        }
                    }
                }
                .navigationTitle(Text("Colors"))
                .onOpenURL(perform: { (url) in
                    guard let activeCharacter = colorsList.filter({$0.url == url}).first else { return }
                    activeID = activeCharacter.id
                })
            }
        }
    }
}

struct DestinationView: View {
    var color: ColorsModel
    
    var body: some View {
        ZStack {
            color.mainColor.edgesIgnoringSafeArea(.all)
            Text("\(color.name)")
                .bold()
                .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
