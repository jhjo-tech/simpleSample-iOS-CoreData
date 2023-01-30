//
//  ContentView.swift
//  SimpleSample-iOS-CoreDataApp
//
//  Created by Jo JANGHUI on 2023/01/28.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Image(systemName: "")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(.gray)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Save Image")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.blue)
            
            Button {
                
            } label: {
                Text("Show Image")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.blue)
            
            Spacer()
            
            Image(systemName: "")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(.gray)
            
            Spacer()
            
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
